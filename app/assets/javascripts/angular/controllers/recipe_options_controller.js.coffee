'use strict'

# Selects the next option of a recipe. It returns to the first option
# if the limit is exceeded.
nextOption = (options, current) ->
  index = _.indexOf(options, current) + 1
  index = 0 if index == options.length #when exceeds option length
  options[index]

# Updates the recipe
updateRecipe = (recipe, recipe_form) ->
  recipe_form.$update().then (responseJSON) ->
    _.extend recipe, responseJSON

# Sets the recipe to be updated in 2 seconds if no other change is
# made to the options meanwhile
setDelayedUpdate = ($scope, $timeout) ->
  $timeout.cancel($scope.updateTimeout)
  $scope.updateTimeout = $timeout ->
    updateRecipe($scope.recipe, $scope.recipe_form)
  , 1500


# Controls the recipe options (time, difficulty, guests) and its update.
recipeOptionsCtrl = ($scope, $timeout) ->
  difficulties = [null, "easy", "medium", "hard"]
  times = [null, "15'", "30'", "45'", "60'", "+90'"]
  guests = [null, "2", "4", "6", "+8"]

  $scope.increaseDifficulty = ->
    current = $scope.recipe_form.difficulty
    $scope.recipe_form.difficulty = nextOption(difficulties, current)
    setDelayedUpdate $scope, $timeout

  $scope.increaseTime = ->
    current = $scope.recipe_form.time
    $scope.recipe_form.time = nextOption(times, current)
    setDelayedUpdate $scope, $timeout

  $scope.increaseGuests = ->
    current = $scope.recipe_form.guests
    $scope.recipe_form.guests = nextOption(guests, current)
    setDelayedUpdate $scope, $timeout

angular.module('cookinme.controllers').
  controller 'RecipeOptionsCtrl', ['$scope', '$timeout', recipeOptionsCtrl]