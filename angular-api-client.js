/* vim: set ts=2 et sw=2 tw=80: */
/* license: public domain */
// Usage:
//
//  angular.module('api', ['AngularAPIClient'])
//  .factory('$api', function (AngularAPIClient) {
//    return {
//      entry: AngularAPIClient.make([
//        ['query',  'GET',  '/entry/query'],
//        ['create', 'POST', '/entry/create'],
//      ]),
//      member: AngularAPIClient.make([
//        ['query',  'GET',  '/member/query'],
//      ])
//    };
//  });
(function () {
  "use strict";

  angular.module('AngularAPIClient', ['ng'])
  .factory('AngularAPIClient', ['$http', function ($http) {
    var create_method = function (info) {
      var http_method = info[1];
      var endpoint    = info[2];

      return function (params, success_cb, error_cb) {
        if (angular.isFunction(params)) {
          throw "usage: params, success_cb, error_cb";
        }

        var promise = $http({
          'method': http_method,
          'url': endpoint,
          params:params
        });
        if (success_cb) {
          promise.success(success_cb);
        }
        if (error_cb) {
          promise.error(error_cb);
        }
        return promise;
      };
    };
    return {
      make: function (infos) {
        var obj = {};
        for (var i=0,l=infos.length; i<l; i++) {
          obj[infos[i][0]] = create_method(infos[i]);
        }
        return obj;
      }
    };
  }]);
})();
