package y.controls
{
	import y.display.RectangleYDisplay;

	public class YRectangle extends YDisplayObject
	{
		override protected function createUIE() : void
		{
			uie = new RectangleYDisplay();
		}
		
		public function get t() : RectangleYDisplay
		{
			return uie as RectangleYDisplay;			
		}
		
		public function get color():Number { return t.color; }
		public function set color(value:Number):void { t.color = value;}
	}
}
