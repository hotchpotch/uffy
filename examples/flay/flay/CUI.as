package flay {
    import flash.events.EventDispatcher;
    import uffy.javascript;
    import flash.utils.getTimer;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class CUI {

        public var _now:Number;
        javascript function now():Number {
            _now ||= getTimer();
            return _now;
        }

        javascript function bar():String {
            log('jsbar');
            return 'return bar';
        }

        javascript function getURL(url:String, completeCallback:Function):void {
            var u:URLRequest = new URLRequest(url);
            var l:URLLoader= new URLLoader();
            l.addEventListener(Event.COMPLETE, function(e:Event):void {
                completeCallback(e.target.data);
            });
            l.load(u);
        }
    }
}
