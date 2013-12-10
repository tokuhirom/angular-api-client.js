This is a tiny api client library for AngularJS.

# SYNOPSIS

Define resource class.

    angular.module('myapp.api', ['AngularAPIClient'])
    .factory('api', function (AngularAPIClient) {
      return {
        entry: AngularAPIClient.make([
          ['query',  'GET',  '/entry/query'],
          ['create', 'POST', '/entry/create'],
        ]),
        member: AngularAPIClient.make([
          ['query',  'GET',  '/member/query'],
        ])
      };
    });

And use it.

    angular.module('myapp', ['myapp.api'])
    .controller('EntryCtrl', function (api) {
      $api.entry.query({}, function (dat) {
        $scope.rows = $scope.rows.concat(dat.rows);
      });
    });

# TESTING

    > culr http://cpanmin.us/ | perl - Plack
    > plackup test.psgi

# LICENSE

public domain

