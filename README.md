This is a tiny api client library for AngularJS.

# SYNOPSIS

Define resource class.

    angular.module('myapp.api', ['ngAPIClient'])
    .factory('$api', function ($apiClient) {
      return {
        entry: $apiClient.make([
          ['query',  'GET',  '/entry/query'],
          ['create', 'POST', '/entry/create'],
        ]),
        member: $apiClient.make([
          ['query',  'GET',  '/member/query'],
        ])
      };
    });

And use it.

    angular.module('myapp', ['myapp.api'])
    .controller('EntryCtrl', function ($api) {
      $api.entry.query({}, function (dat) {
        $scope.rows = $scope.rows.concat(dat.rows);
      });
    });

# LICENSE

public domain

