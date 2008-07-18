window.onload = function() {
    var uffy = new Uffy('./Test.swf?' +(new Date).getTime());
    uffy.load('UffyTest', function(UffyTest) {
      var t1 = new UffyTest();
      is('foo', t1.foo(), 'foo');
      is([1,2,3], t1.refrect(1,2,3), 'refrect1');
      t1.callFunc(1, function(e) {
        is(1, e, 'callFunc1');
      });
      t1.callFunc([1,2], function(e) {
        is([1,2], e, 'callFunc2');
      });
    });
    
    uffy.load('ClassVariableTest', function(ClassVariableTest) {
        var c1 = new ClassVariableTest();
        var c2 = new ClassVariableTest();
    
        ok(!(c1.getCount() == c2.getCount()), 'class variable test');
    });
}
