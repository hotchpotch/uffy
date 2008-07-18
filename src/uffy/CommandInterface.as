package uffy {
    import flash.external.ExternalInterface;
    import flash.utils.describeType;
    import flash.utils.Dictionary;

    public class CommandInterface {
        public static function register(constName:String, klass:Class):void {
            if (!ExternalInterface.available) return;

            init();
            classes[constName] = klass;

            ExternalInterface.call(<><![CDATA[ 
                (function(constName, objectID, methods) {
                   var registerSwf = function(swf) {
                       if (!swf.__functionWrapper) {
                           var FunctionWrapper = {
                               _funcs: [],
                               register: function(func) {
                                   FunctionWrapper._funcs.push(func);
                                   return FunctionWrapper._funcs.length - 1;
                               },
                               registerArgs: function(_arguments) {
                                   var array = [];
                                   for (var i = 0; i < _arguments.length; i++) {
                                       var arg = _arguments[i];
                                       if (typeof arg == 'function') {
                                           array.push('__function__id__' + FunctionWrapper.register(arg));
                                       } else {
                                           array.push(arg);
                                       }
                                   }
                                   return array;
                               },
                               execute: function(fid) {
                                   var args = Array.prototype.slice.call(arguments, 0, arguments.length);
                                   return FunctionWrapper._funcs[args.shift()].apply(null, args);
                               }
                           };
                           swf.__functionWrapper = FunctionWrapper;
                       }

                       var klass = function() {
                           this.initialize.apply(this, arguments);
                       };
                       klass.prototype = {
                           initialize: function() {
                               var args = Array.prototype.slice.call(arguments, 0, arguments.length);
                               this._uid = swf.__register.apply(swf, [constName].concat(swf.__functionWrapper.registerArgs(args)));
                           }
                       };
                       for (var j = 0; j < methods.length; j++) {
                           klass.prototype[methods[j]] = (function() {
                               var mName = methods[j];
                               return function() {
                                   var args = Array.prototype.slice.call(arguments, 0, arguments.length);
                                   return swf.__invoke.apply(swf, [this._uid, mName].concat(swf.__functionWrapper.registerArgs(args)));
                               };
                           })();
                       }
                       swf[constName] = klass;
                   };

                   (function() {
                       var swf = document.getElementsByName(objectID)[0];
                       if (!swf) {
                           setTimeout(arguments.callee, 20);
                       } else {
                           registerSwf(swf);
                       }
                   })();
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

            ExternalInterface.addCallback('__register', javascriptRegister);
            ExternalInterface.addCallback('__invoke', javascriptInvoker);
        }

        protected static function javascriptRegister(constName:String, ...args):uint {
            var klass:Class = classes[constName] as Class;
            javascripts[++counter] = args.length ? new klass(functionWrapper(args)) : new klass();
            return counter;
        }

        protected static function javascriptInvoker(uid:uint, methodName:String, ...args):* {
            var asInstance:Object = javascripts[uid];
            return asInstance.javascript::[methodName].apply(asInstance, functionWrapper(args));
        }

        protected static function functionWrapper(args:Array):Array {
            for (var i:uint = 0; i < args.length; i++) {
                var item:* = args[i];
                if (item as String && item.indexOf('__function__id__') == 0) {
                    var fid:uint = uint(item.replace('__function__id__', ''));
                    args[i] = function(..._args):* {
                        return selfCallJS.apply(null, ['__functionWrapper.execute', fid].concat(_args));
                    }
                }
            }
            return args;
        }

        public static function callJS(cmd:String, ...args):* {
            if (!ExternalInterface.available)
                return null;

            if (args.length > 0) {
                cmd = "(function() {" + cmd + ".apply(null, arguments);})";
                return ExternalInterface.call.apply(null, [cmd].concat(args));
            } else {
                cmd = "(function() {" + cmd + ".call(null);})";
                return ExternalInterface.call(cmd);
            }
        }

        public static function selfCallJS(cmd:String, ...args):* {
            cmd = "return document.getElementById('" + ExternalInterface.objectID + "')." + cmd;
            return callJS.apply(null, [cmd].concat(args));
        }
        

        public static function nsMethods(klass:Class, ns:Namespace):Array {
            return describeType(klass)..method.(String(attribute('uri')) == ns.uri).@name.toXMLString().split("\n");
        }
    }
}
