'use strict'

baseCtrl = ($scope, $http, $window, current_user) ->

  $scope.current_user = current_user.data

  $scope.setCookbook = (cookbook) ->
    $scope.cookbook = cookbook

  $scope.signOut = ->
    $http.delete('api/sign_out').success (data, status) ->
      $window.location.href = "/"

angular.module('cookinme.controllers', ['ui.router']).
  controller 'BaseCtrl',
    ['$scope', '$http', '$window', 'current_user', baseCtrl]