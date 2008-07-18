package uffy {
    import flash.external.ExternalInterface;
    import flash.utils.describeType;
    import flash.utils.Dictionary;

    public class CommandInterface {
        public static function register(constName:String, klass:Class) {
            init();
            classes[constName] = klass;

            ExternalInterface.call(<><![CDATA[ 
                (function(constName, objectID, methods) {
                   var swf = document.getElementsByName(objectID)[0];
                   var klass = function() {
                       this.initialize.apply(this, arguments);
                   };
                   klass.prototype = {
                       initialize: function() {
                           this._uid = swf.register.apply(swf, [constName].concat(Array.prototype.slice.call(arguments, 0, arguments.length)));
                       }
                   };
                   for (var i = 0; i < methods.length; i++) {
                       var mName = methods[i];
                       klass.prototype[mName] = function() {
                           return swf.invoke.apply(swf, [this._uid, mName].concat(Array.prototype.slice.call(arguments, 0, arguments.length)));
                       }
                   }
                   swf[constName] = klass;
                ;})
            ]]></>.toString(), 
              constName, 
              ExternalInterface.objectID,
              nsMethods(klass, javascript)
            );
        }

        protected static var inited:Boolean = false;
        protected static var javascripts:Dictionary;
        protected static var counter:uint;
        protected static var classes:Dictionary;
        public static function init():void {
            if (inited) return;
            inited = true;
            counter = 0;
            javascripts = new Dictionary();
            classes = new Dictionary();

            ExternalInterface.addCallback('register', javascriptRegister);
            ExternalInterface.addCallback('invoke', javascriptInvoker);
        }

        protected static function javascriptRegister(constName:String, ...args):uint {
            var klass:Class = classes[constName] as Class;
            javascripts[++counter] = args.length ? new klass(args) : new klass();
            return counter;
        }

        protected static function javascriptInvoker(uid:uint, methodName:String, ...args):* {
            var asInstance:Object = javascripts[uid];
            return asInstance.javascript::[methodName].apply(asInstance, args);
        }

        public static function nsMethods(klass:Class, ns:Namespace):Array {
            return describeType(klass)..method.(String(attribute('uri')) == ns.uri).@name.toXMLString().split("\n");
        }
    }
}
