'use strict'

# Controls the Cookbook page. Including removing and updating the cookbook
# and reordering.
cookbookCtrl = ($scope, $state, $stateParams, cookbook, Cookbook) ->
  $scope.setCookbook cookbook # Sets the parent scope

  cookbook.$promise.then ->
    $scope.cookbook_form = angular.copy cookbook, new Cookbook

  $scope.filterModel = '-id' # Minus sign means 'reverse order'

  $scope.removeCookbook = ->
    $scope.cookbook.$remove ->
      $state.go 'cookbooks'

  $scope.updateTitle = ->
    $scope.cookbook_form.$update()
    $scope.cookbook.title = $scope.cookbook_form.title

angular.module('cookinme.controllers').
  controller 'CookbookCtrl',
    ['$scope', '$state', '$stateParams', 'cookbook', 'Cookbook', cookbookCtrl]