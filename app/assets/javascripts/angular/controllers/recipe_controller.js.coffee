'use strict'

# Controls the Recipe state including recipe photo uploading, updating fields,
# removing recipes, etc.
recipeCtrl = ($scope, $stateParams, $state, Recipe) ->
  $scope.cookbook.$promise.then ->
    $scope.recipe = _.findWhere $scope.cookbook.recipes,
      id: parseInt($stateParams.recipeId)
    $scope.recipe_form = angular.copy $scope.recipe, new Recipe
    $scope.showRecipe = true

  $scope.applyChanges = ->
    $scope.recipe_form.$update().then (responseJSON) ->
      _.extend $scope.recipe, responseJSON

  $scope.afterUploadPhoto = (responseJSON) ->
    _.extend $scope.recipe_form, responseJSON
    _.extend $scope.recipe, responseJSON

  $scope.removePhoto = ->
    $scope.recipe_form.$remove_photo ->
      _.extend $scope.recipe, $scope.recipe_form

  $scope.removeRecipe = ->
    $scope.recipe_form.$remove ->
      # Delete recipe from cookbook scope
      $scope.cookbook.recipes = _.reject $scope.cookbook.recipes, (recipe) ->
        recipe.id == $scope.recipe.id

      # Transition to the cookbook
      $state.go 'cookbook', cookbookId: $scope.cookbook.id

angular.module('cookinme.controllers').
  controller 'RecipeCtrl',
    ['$scope', '$stateParams', '$state', 'Recipe', recipeCtrl]