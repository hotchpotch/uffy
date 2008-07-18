//var uffy = new Uffy();
//uffy.load('imeonoff', 'http://example.com/IMEOnOff.swf');
//uffy.libraries(); #=>;
//uffy.imeOnOff.off();
//uffy.addLoadedLibraryHandler('imeonoff', function(lib){
//  lib.name; #=> imeonoff'
//} );


Uffy = function () {
    this.initialize.apply(this, arguments);
};

Uffy.loadHandler = function() {
    Uffy.dispatchEvent('load');
};

Uffy.prototype = {
    initialize: function() {
        this.libraries = {};
        this.uniqId = '_' + (new Date).getTime() + (new Date).getMilliseconds();
    },
    load: function(name, libraryUrl) {
        if (this[name])
            throw name + ' is defined.';
        this[name] = new Uffy.Library(this, name, libraryUrl);
        this.libraries[name] = this[name];
        return this[name];
    }
};

Uffy.Library = function() {
    this.initialize.apply(this, arguments);
};

Uffy.Library.prototype = {
    initialize: function(uffy, name, url) {
        this.uffy = uffy;
        this.name = name;
        this.url = url;
        this._loadSWF();
    },
    getSWFName: function() {
        return this.name + this.uffy.uniqId;
    },
    _loadSWF: function(url) {
        if (navigator.plugins && navigator.mimeTypes && navigator.mimeTypes.length) { 
             var o = document.createElement('object'); 
             o.id = this.getSWFName();
             o.classid = 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'; 
             o.width = 1; 
             o.height = 1; 
             o.setAttribute('data', this.getSWFUrl()); 
             o.setAttribute('type', 'application/x-shockwave-flash'); 
             var p = document.createElement('param'); 
             p.setAttribute('name', 'allowScriptAccess'); 
             p.setAttribute('value', 'always'); 
             o.appendChild(p); 
             div.appendChild(o); 
         } else { 
             // IE 
             var object = '<object id="' + this.getSWFName() + '" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="1" height="1"><param name="movie" value="' + this.getSWFUrl() + '" /><param name="bgcolor" value="#FFFFFF" /><param name="quality" value="high" /><param name="allowScriptAccess" value="always" /></object>'; 
             div.innerHTML = object; 
         } 
    }
}



if (window.addEventListener) { 
    window.addEventListener('load', Uffy.loadHandler, false); 
} else { 
    window.attachEvent('onload', Uffy.loadHandler); 
} 
