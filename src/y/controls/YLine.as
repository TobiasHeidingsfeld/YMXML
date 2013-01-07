package y.controls
{
	import y.display.LineYDisplay;

	public class YLine extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new LineYDisplay();
		}
		
		public function get t():LineYDisplay { return uie as LineYDisplay; }
		
		public function get color():Number { return t.color; }
		public function set color(value:Number):void { setProperty("color", value);}
		
		public function get thickness():Number { return t.thickness; }
		public function set thickness(value:Number):void { setProperty("thickness", value);}
		
		public function get toX():Number { return t.toX; }
		public function set toX(value:Number):void { setProperty("toX", value);}
		
		public function get toY():Number { return t.toY; }
		public function set toY(value:Number):void { setProperty("toY", value);}
	
	}
}
