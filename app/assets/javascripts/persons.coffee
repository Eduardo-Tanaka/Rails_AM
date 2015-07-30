# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.datepicker').datepicker
    language: "pt-BR",
    format: 'dd/mm/yyyy'

  $("#person_cpf").mask("999.999.999-99")

  $("#person_phones_attributes_0_phone").mask("(99) 9999-9999");
  $("#person_phones_attributes_1_phone").mask("(99) 9999-9999?9");

  $("#person_address_attributes_zipcode").mask("99999-999")

  $("#person_address_attributes_zipcode").blur ->
    $.ajax
      url: "http://api.postmon.com.br/v1/cep/" + $(this).val(),
      type: "GET",
      success: (data) ->
        $("#person_address_attributes_address").val(data.logradouro.toUpperCase())
        $("#person_address_attributes_neighborhood").val(data.bairro.toUpperCase())
        $("#person_address_attributes_city").val(data.cidade.toUpperCase())
        $("#person_address_attributes_state").val(data.estado.toUpperCase())
