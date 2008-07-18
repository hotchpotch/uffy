
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
        var div = document.createElement('div');
        div.style.display = 'inline';
        div.width = 1;
        div.height = 1;
        document.body.appendChild(div);

        if (navigator.plugins && navigator.mimeTypes && navigator.mimeTypes.length) {
            var o = document.createElement('object');
            o.id = swf_id;
            o.name = swf_id;
            o.classid = 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000';
            o.width = 1;
            o.height = 1;
            o.setAttribute('data', swf);
            o.setAttribute('type', 'application/x-shockwave-flash');
            var p = document.createElement('param');
            p.setAttribute('name', 'allowScriptAccess');
            p.setAttribute('value', 'always');
            o.appendChild(p);
            div.appendChild(o);
        } else {
            // IE
            var object = '<object id="' + swf_id + '" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="1" height="1"><param name="movie" value="' + swf + '" /><param name="bgcolor" value="#FFFFFF" /><param name="quality" value="high" /><param name="allowScriptAccess" value="always" /></object>';
            div.innerHTML = object;
        }
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
            setTimeout(function(){self.load(name, callback)}, 30);
        }
    }
};

