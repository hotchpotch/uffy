package {
    import flash.display.Sprite;
    import uffy.Uffy;

    public class GetURL extends Sprite {
        public function GetURL() {
            Uffy.register('URI', URI);
        }
    }
}

import uffy.javascript;
import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.events.Event;

class URI {
    javascript function getURL(url:String, compFunc:Function):void {
        var loader:URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, function(e:Event):void {
            compFunc(e.target.data);
        });
        loader.load(new URLRequest(url));
    }
}

/*
 * var uffy = new Uffy('GetURL.swf');
 * uffy.load('URI', function(URI) {
 *   var uri = new URI;
 *   uri.getURL('http://webservices.amazon.co.jp/crossdomain.xml', alert);
 * });
 */
