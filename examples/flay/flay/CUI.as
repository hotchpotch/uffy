package flay {
    import flash.events.EventDispatcher;
    import uffy.javascript;

    public class CUI extends EventDispatcher {
        use namespace javascript;

        public function CUI() {
        }

        javascript function foo():String {
            log('jsfoo');
            return 'return foo';
        }

        javascript function bar():String {
            log('jsbar');
            return 'return foo';
        }
    }
}
