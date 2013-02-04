package y.controls
{
	import y.display.ImageYDisplay;
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
		
		public function set icon(value:Object):void { t.defaultIcon = new ImageYDisplay(value);}
		
		public function get wordWrap():Boolean { return t.defaultLabelProperties["wordWrap"]; }
		public function set wordWrap(value:Boolean):void { t.defaultLabelProperties["wordWrap"] = value;}
		
		public function get isToggle():Boolean { return t.isToggle; }
		public function set isToggle(value:Boolean):void { t.isToggle = value;}
		
		public function get enabled():Boolean { return t.isEnabled; }
		public function set enabled(value:Boolean):void { t.isEnabled = value;}
		
		public function set fontSize(value:Number):void { TextFormatHelper.setFontSize(t.defaultLabelProperties, value);}
		
		public function set fontColor(value : Number) : void	{ TextFormatHelper.setFontColor(t.defaultLabelProperties, value);}
		
		public function set fontAlign(value : String) : void { TextFormatHelper.setFontAlign(t.defaultLabelProperties, value);}		
	}
}
