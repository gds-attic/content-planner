# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jsTags = ->
  $("input.js-tags").select2
    tags: true
    initSelection: (element, callback) ->
      data = []
      $(element.val().split(",")).each ->
        data.push
          id: $.trim(this)
          text: $.trim(this)
      callback data
    ajax:
      url: "/tags"
      dataType: "json"
      data: (term, page) ->
        q: term
        page: page

      results: (data, page) ->
        results: data

$(document).ready jsTags
$(document).on "page:load", jsTags

jsContentPlans = ->
  $("#source_url_content_plan_ids").select2()
  $("#content_content_plan_ids").select2()
  $("#search_content_plan_ids").select2
    allowClear: true

$(document).ready jsContentPlans
$(document).on "page:load", jsContentPlans

jsNeeds = ->
  $(".js-needs").select2
    placeholder: "User needs"
    allowClear: true

$(document).ready jsNeeds
$(document).on "page:load", jsNeeds

jsContents = ->
  $('#content_user_ids').select2()

$(document).ready jsContents
$(document).on "page:load", jsContents

jsOrganisations = ->
  $(".js-organisations").select2
    placeholder: "Organisation"
    allowClear: true

$(document).ready jsOrganisations
$(document).on "page:load", jsOrganisations

select2Default = ->
  $(".select2").select2
    allowClear: true

$(document).ready select2Default
$(document).on "page:load", select2Default
