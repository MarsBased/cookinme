'use strict'

# Controls the header buttons when the user is viewing all his Cookbooks.
cookbooksHeaderCtrl = ($scope, $state, Cookbook) ->

  # Add a new cookbook action.
  $scope.addCookbook = ->
    $scope.newCookbook = new Cookbook
    $scope.newCookbook.$save ->
      $state.go 'cookbook', {
        cookbookId: $scope.newCookbook.id
      }

angular.module('cookinme.controllers').
  controller 'CookbooksHeaderCtrl',
    ['$scope', '$state', 'Cookbook', cookbooksHeaderCtrl]