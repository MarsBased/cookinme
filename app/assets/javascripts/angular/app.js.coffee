'use strict'

dependencies = ['cookinme.directives', 'cookinme.states', 'cookinme.services',
  'cookinme.controllers', '$strap.directives', 'ui.keypress', 'ui.event',
  'ngAnimate']

config = ($httpProvider) ->
  # Used to be conformant with the CSRF Rails Token
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

  # Specify json as a content type for all requests
  $httpProvider.defaults.headers.common["Content-Type"] = "application/json"

run = ($rootScope, $state, $stateParams) ->
  # Sets the state and the stateParams as a rootScope variable
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams


angular.module('cookinme', dependencies).
  config(['$httpProvider', config]).
  run(['$rootScope', '$state', '$stateParams', run])