package y.controls
{
	import y.display.ImageYDisplay;

	public class YImage extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new ImageYDisplay();
		}
		
		public function get t():ImageYDisplay { return uie as ImageYDisplay; }
		
		public function get source():Object { return t.source; }
		public function set source(value:Object):void { t.source = value;}	
	}
}
