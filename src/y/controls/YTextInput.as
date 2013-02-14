package y.controls
{
	import feathers.controls.TextInput;

	[Event(name="enter", type="flash.events.Event")]
	public class YTextInput extends YDisplayObject
	{
		override protected function createUIE() : void
		{
			uie = new TextInput();			
		}
		
		public function get t():TextInput { return uie as TextInput; }
		
		public function get text():String { return t.text; }
		public function set text(value:String):void { t.text = value;} 

		public function set fontSize(value : Number) : void	{ t.textEditorProperties["fontSize"] = value;}
		
		public function set editable(value : Boolean) : void	{ t.textEditorProperties["editable"] = value;}
		
//		public function set fontColor(value : Number) : void { TextFormatHelper.setFontColor(t.textEditorProperties, value);}
//		
//		public function set fontAlign(value : String) : void { TextFormatHelper.setFontAlign(t.textEditorProperties, value);}
	}
}
