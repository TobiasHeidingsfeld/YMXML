package y.controls
{
	import feathers.controls.TextInput;

	public class YTextInput extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new TextInput();			
		}
		
		public function get t():TextInput { return uie as TextInput; }
		
		public function get text():String { return t.text; }
		public function set text(value:String):void { t.text = value;} 

	}
}
