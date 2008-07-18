package {
    import flash.display.Sprite;
    import uffy.Uffy;

    public class ExifExample extends Sprite {
        public function ExifExample() {
            Uffy.register('Exif', Exif);
        }
    }
}

// exif library is http://code.shichiseki.jp/as3/ExifInfo/
import jp.shichiseki.exif.*;
import flash.events.Event;
import flash.net.URLRequest;
import uffy.javascript;

class Exif {
    public var imageURL:String;
    public function Exif(imageURL:String) {
        this.imageURL = imageURL;
    }

    javascript function load(callback:Function):void {
        var loader:ExifLoader = new ExifLoader();
        loader.addEventListener(Event.COMPLETE, function(e:Event):void {
            if (loader.exif.ifds) callback(loader.exif.ifds.exif);
        });
        loader.load(new URLRequest(this.imageURL));
    }
}
