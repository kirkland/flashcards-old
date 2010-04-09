// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function mark_for_destroy(element) {
    $(element).next('.should_destroy').value = 1;
    $(element).up('.card').hide();
}

function reveal_back(new_text) {
    $('cardback').replace(new_text);
    //    new Insertion.top($('cardback'),new_text)
}