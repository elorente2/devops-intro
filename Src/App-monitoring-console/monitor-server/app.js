var myAppModule = angular.module("myApp", []);

myAppModule.controller('MyController', function($scope, pollingService, $interval) {

    $scope.data = pollingService.data;
    var stop = $interval(function() {
        pollingService.poller().then(function(result) {
            console.log('ok');
            $scope.result = result;

        })
    }, 2000);



});

myAppModule.service("pollingService", function($http, $timeout, $rootScope, $q) {

    var data = { resp: {} };
    var count = 0;
    var myMap = {}
    var counter = 1
    var poller = function() {
        count++;
        return $q(function(resolve, reject) {
            $http.get('http://httpbin.org/delay/1?now=' + Date.now()).then(function(result) {

                console.log(result)
                    // var resp = {
                    //     identifier: result.data.svc + '-' + result.hostname,
                    //     msg: result.msg

                // }
                resolve(result);

            });
        })
    };

    return {
        poller: poller
    };
});