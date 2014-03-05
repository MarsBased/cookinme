'use strict'

cookbookFactory = ($resource) ->
  $resource '/api/cookbooks/:id', {id: '@id'},
    update:
      method:'PUT'

recipeFactory = ($resource) ->
  $resource '/api/recipes/:id/:verb', {id: '@id'},
    update:
      method:'PUT'
    remove_photo:
      method:'DELETE'
      params:
        verb: 'remove_photo'
    update_cookbook:
      method:'PUT'
      params:
        verb: 'update_cookbook'
    remove_cookbook:
      method:'DELETE'
      params:
        verb: 'remove_cookbook'

userFactory = ($resource) ->
  $resource '/api/current_user/:verb', {},
    update:
      method:'PUT'
    remove_avatar:
      method:'DELETE'
      params:
        verb: 'remove_avatar'

angular.module('cookinme.services', ['ngResource']).
  factory('Cookbook', ['$resource', cookbookFactory]).
  factory('Recipe', ['$resource', recipeFactory]).
  factory('User', ['$resource', userFactory])
