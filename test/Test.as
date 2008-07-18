package {
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import uffy.Uffy;

    [SWF(frameRate=60, background=0x000000)]
    public class Test extends Sprite {
        public function Test() {
            log('a');
            Uffy.register('UffyTest', UffyTest);
        }
    }
}

import uffy.javascript;

    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.net.URLLoader;

class UffyTest {
    javascript function foo():String {
        return 'foo';
    }

    javascript function getURL(url:String, compFunc:Function):void {
        var loader:URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, function(e:Event):void {
            compFunc.call(null, e.target.data);
        });
        loader.load(new URLRequest(url));
    }
}
