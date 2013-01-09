package y.controls
{
	import feathers.controls.TextInput;

	import y.util.TextFormatHelper;

	public class YTextInput extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new TextInput();			
		}
		
		public function get t():TextInput { return uie as TextInput; }
		
		public function get text():String { return t.text; }
		public function set text(value:String):void { t.text = value;} 

		public function set fontSize(value : Number) : void	{ TextFormatHelper.setFontSize(t.textEditorProperties, value);}
		
		public function set fontColor(value : Number) : void { TextFormatHelper.setFontColor(t.textEditorProperties, value);}
		
		public function set fontAlign(value : String) : void { TextFormatHelper.setFontAlign(t.textEditorProperties, value);}
	}
}
