package {
    import flash.display.Sprite;
    import uffy.Uffy;

    [SWF(frameRate=60, background=0x000000)]
    public class GetURL extends Sprite {
        public function GetURL() {
            Uffy.register('URI', URI);
        }
    }
}

import uffy.javascript;
import flash.net.URLRequest;
import flash.events.Event;
import flash.net.URLLoader;

class URI {
    javascript function getURL(url:String, compFunc:Function):void {
        var loader:URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, function(e:Event):void {
            compFunc.call(null, e.target.data);
        });
        loader.load(new URLRequest(url));
    }
}

/*
 * var uffy = new Uffy('GetURL.swf');
 * uffy.load('URI', function(URI) {
 *   var uri = new URI;
 *   uri.getURL('http://github.com', fucntion(data) { alert(data) } );
 * });
