'use strict'

angular.module('frontApp')
  .controller('LoginCtrl', function ($scope, $http, User) {

    $scope.sign_in = function () {
      User.sign_in($scope.user_sign_in).error(function (data) {
        $scope.api_errors = data
      })
    }

    $scope.sign_out = function () {
      User.sign_out($scope.user_sign_in).error(function (data) {
        $scope.api_errors = data
      })
    }

    $scope.sign_up = function () {
      User.sign_up($scope.user_sign_up).error(function (data) {
        $scope.api_errors = data
      })
    }
  })