'use strict';

angular.module('frontApp')
  .factory('User', function ($http) {
    var apiUrl = '/api/v1/'

    return {
      sign_in: function (data) {
        return $http.post(apiUrl + 'users/sign_in.json', {user: data})
      },
      sign_out: function (data) {
        return $http.delete(apiUrl + 'users/sign_out.json', data)
      },
      sign_up: function (data) {
        return $http.post(apiUrl + 'users.json', {user: data})
      }
    }
  })