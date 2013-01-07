package y.controls
{
	import feathers.controls.Button;
	import y.util.TextFormatHelper;

	
	[Event(name="click", type="flash.events.MouseEvent")]
	public class YButton extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new Button();
			t.useHandCursor = true;
		}
		
		public function get t():Button { return uie as Button; }
		
		public function get label():String { return t.label; }
		public function set label(value:String):void { t.label = value;}

		public function get enabled():Boolean { return t.isEnabled; }
		public function set enabled(value:Boolean):void { t.isEnabled = value;}
		
		public function set fontSize(value:Number):void { TextFormatHelper.setFontSize(t.defaultLabelProperties, value);}		
	}
}
