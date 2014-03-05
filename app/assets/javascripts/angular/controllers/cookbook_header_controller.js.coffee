'use strict'

# Controls the header buttons when the user is viewing a Cookbook.
cookbookHeaderCtrl = ($scope, $state, Recipe) ->

  # Add Recipe Button.
  $scope.addRecipe = ->
    $scope.newRecipe = new Recipe {
      cookbook_id: $scope.cookbook.id
    }

    $scope.newRecipe.$save ->
      $scope.cookbook.recipes.push $scope.newRecipe
      $state.go 'recipe', {
        cookbookId: $scope.cookbook.id
        recipeId: $scope.newRecipe.id
      }

angular.module('cookinme.controllers').
  controller 'CookbookHeaderCtrl',
    ['$scope', '$state', 'Recipe', cookbookHeaderCtrl]