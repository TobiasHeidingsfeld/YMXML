package y.controls
{
	import y.display.SplitImageYDisplay;
	public class YSplitImage extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new SplitImageYDisplay();
		}
		
		public function get t():SplitImageYDisplay { return uie as SplitImageYDisplay; }
		
		public function get source():Object { return t.source; }
		public function set source(value:Object):void { t.source = value;}
		
		public function get imageSplits():Array { return t.imageSplits; }
		public function set imageSplits(value:Array):void { t.imageSplits = value;}
		
		public function get imageParts():Array { return t.imageParts; }	
	}
}
