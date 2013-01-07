package y.controls
{
	import starling.display.Quad;

	public class YRect extends YSprite
	{
		private var quad : Quad = new Quad(20, 20, 0xFF0000);
		
		override protected function createUIE() : void
		{
			super.createUIE();						
		}
		
		override public function set width(value : Number) : void
		{
			super.width = value;
			quad.width = value;
		}

		override public function set height(value : Number) : void
		{
			super.height = value;
			quad.height = value;			
		}
		
		public function get color():Number { return quad.color; }
		public function set color(value:Number):void { quad.color = value;}

	}
}
