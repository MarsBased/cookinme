'use strict'

# Controls the All cookbooks page.
cookbooksCtrl = ($scope, $state, cookbooks) ->
  $scope.cookbooks = cookbooks
  $scope.filterModel = '-id' # Minus sign sets 'reverse order'

angular.module('cookinme.controllers').
  controller 'CookbooksCtrl', ['$scope', '$state', 'cookbooks', cookbooksCtrl]