package {
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import uffy.Uffy;

    public class Test extends Sprite {
        public function Test() {
            Uffy.register('UffyTest', UffyTest);
            Uffy.register('ClassVariableTest', ClassVariableTest);
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

    javascript function refrect(...args):* {
        return args;
    }

    javascript function callFunc(arg1:*, func:Function):* {
        return func(arg1);
    }
}

class ClassVariableTest {
    public static var count:uint = 0;

    public var _count:uint;
    public function ClassVariableTest() {
        this._count = count++;
    }

    javascript function getCount():uint {
        return this._count;
    }
}
