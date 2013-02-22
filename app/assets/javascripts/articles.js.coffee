$(document).ready ->
  $("#article_form").submit ->
    $("#form_submit").val("The eels are translating...")

  $(".hovercraft_original").click ->
    block_id = $(this).attr("data-original-block")
    $(".hovercraft_translation[data-translation-block=" + block_id + "]").toggle()
