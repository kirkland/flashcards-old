// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function mark_for_destroy(element) {
    $(element).next('.should_destroy').value = 1;
    $(element).up('.card').hide();
}

function reveal_back(new_text) {
    //    $(element).hide()
    //    $(element).up().up('div').hide()
    //    $(element).up().up('div').down('div').hide()
    //    $('cardback').hide()
    //    $('cardback').replace(@deck.cards[0].back) // doesn't work, no such variable. 
    $('cardback').replace(new_text);
}