'use strict'

# When the user presses the Enter key, a blur event is launched.
blurOnEnter = ->
  (scope, elm, attrs) ->
    elm.bind 'keyup', (evt) ->
      # intro is pressed
      this.blur() if evt.which == 13

# When the parameter attach to the directive changes, a fade animation
# is launched to change the value.
bindWithAnimation = ->
  (scope, elm, attrs) ->
    scope.$watch attrs.bindWithAnimation, (newValue, oldValue) ->
      if newValue != oldValue
        $(elm).fadeOut 200, ->
          elm.html newValue
          $(this).fadeIn 200
      else
        elm.html newValue

# Disables the click event on every element this directive is attached.
disableClickEvent = ->
  (scope, elm, attrs) ->
    $(elm).on "click", (e) ->
      e.stopPropagation()
      false

# Used for server side validations. Removes the server
# validation every time the input changes.
serverError = ->
  restrict: 'A'
  require: '?ngModel'
  link: ($scope, element, attrs, ctrl) ->
    element.on "change", ->
      $scope.$apply ->
        ctrl.$setValidity 'server', true

# Implements the FineUploader as a directive for AngularJS.
fineUploader = ->
  restrict: 'A'
  link: ($scope, element, attrs) ->
    # We observe the uploadDestination directive to create the uploader
    # only when the uploadDestination has been resolved.
    attrs.$observe 'uploadDestination', ->
      $scope.uploader = new qq.FineUploaderBasic
        button: element[0]
        multiple: false
        request:
          endpoint: attrs.uploadDestination
          customHeaders:
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr("content")
        validation:
          allowedExtensions: attrs.uploadExtensions.split(',')
          sizeLimit: 2097152 # 2 mB = 2 * 1024 * 1024 bytes
        callbacks:
          onComplete: (id, fileName, responseJSON) ->
            func = eval "$scope."+attrs.afterUpload
            func responseJSON;
            $scope.$apply()

angular.module('cookinme.directives', []).
  directive('blurOnEnter', blurOnEnter).
  directive('bindWithAnimation', bindWithAnimation).
  directive('disableClickEvent', disableClickEvent).
  directive('serverError', serverError).
  directive('fineUploader', fineUploader)
