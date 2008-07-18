package {
    import flash.display.Sprite;
    import flay.CUI;
    import flash.external.ExternalInterface;
    import uffy.CommandInterface;

    [SWF(frameRate=60, background=0x000000)]
    public class Flay extends Sprite {
        public function Flay() {
            ExternalInterface.marshallExceptions = true;
            CommandInterface.register('Flay', CUI);
        }
    }
}

