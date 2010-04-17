// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function mark_for_destroy(element) {
    $(element).next('.should_destroy').value = 1;
    $(element).up('.edit-card').hide();
}

function reveal_back(new_text) {
    $('cardback').update(new_text);
    
    $('reveal-button').setStyle({
	    visibility: 'hidden',
		});
}

function play_sound() {
    $('sound').insert( { after: '<embed src="/sounds/gor-gai.mp3" type="application/x-mplayer2" autostart="true" height="0" width="0">' } )
}