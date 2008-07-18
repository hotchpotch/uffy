
Uffy = function() {
    this.initialize.apply(this, arguments);
};

Uffy.prototype = {
    initialize: function(swf, swf_id) {
        this.swf = swf;
        this.swf_id = swf_id || 'uffy_swf';
        this.loadSWF(swf, this.swf_id);
    },
    loadSWF: function(swf, swf_id) {
        // for http://github.com/cho45/flay/tree/master/flay.js
        var html = [
            '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="1" height="1" id="' + swf_id + '" align="middle">',
                '<param name="allowscriptaccess" value="always" />',
                '<param name="movie" value="' + swf + '" />',
                '<param name="quality" value="high" />',
                '<param name="bgcolor" value="#ffffff" />',
                '<embed src="' + swf + '" quality="high" bgcolor="#ffffff" width="1" height="1" name="' + swf_id + '" align="middle" allowscriptaccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />',
            '</object>'
        ];

        var div = document.createElement('div');
        with (div.style) {
            position = "absolute";
            top     = "0";
            left    = "0";
            width   = "0";
            height  = "0";
            margin  = "0";
            padding = "0";
            border  = "none";
        }
        document.body.appendChild(div);
        div.innerHTML = html.join('');
    },
    getSWF: function() {
        return document.getElementById(this.swf_id);
    },
    load: function(name, callback) {
        var swf = this.getSWF();
        if (swf && swf[name]) {
            callback.call(null, swf[name]);
        } else {
            var self = this;
            setTimeout(function(){self.load(name, callback)}, 1000);
        }
    }
};

