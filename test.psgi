use strict;
use JSON::PP;

my $html = <<'...';
<!doctype html>
<html ng-app="Foo">
  <head>
    <meta charset=utf8>
    <title>test.</title>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.4/angular.min.js"></script>
    <script type="text/javascript" src="angular-api-client.js"></script>
    <script type="text/javascript">
      angular.module('Foo', ['AngularAPIClient'])
      .controller(
        'BarCtrl', function ($scope, AngularAPIClient) {
          var api = {
            entry: AngularAPIClient.make([
                ['query', 'GET', '/entry/query']
            ])
          };
          api.entry.query({}, function (dat) {
            $scope.rows = dat;
          });
        }
      );
    </script>
  </head>
  <body ng-controller="BarCtrl">
    <h1>test case for angular-api-client.js</h1>
    <div>
        {{rows}} ← result
    </div>
  </body>
</html>
...

sub html_response {
    my $html = shift;
    [200, ['Content-Type' => 'text/html; charset=utf8'], [$html]];
}

sub file_response {
    my $path = shift;
    open my $fh, '<', $path
        or return not_found_response();
    [200, ['Content-Type' => 'text/plain'], $fh];
}

sub not_found_response {
    [404, ['Content-Length', length('not found')], ['not found']];
}

sub json_response {
    my $dat = shift;
    my $json = encode_json($dat);
    [200, ['Content-Type' => 'application/json; charset=utf8'], [$json]];
}

sub {
    my $env = shift;

    if ($env->{PATH_INFO} eq '/') {
        html_response($html);
    } elsif ($env->{PATH_INFO} eq '/angular-api-client.js') {
        file_response('angular-api-client.js');
    } elsif ($env->{PATH_INFO} eq '/entry/query') {
        json_response({result => 'ok'});
    } else {
        not_found_response();
    }
};

