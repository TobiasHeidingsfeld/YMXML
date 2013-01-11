package y.display
{
	import starling.display.Sprite;
	import starling.display.Quad;

	public class RectangleYDisplay extends Sprite
	{
		private var _quad : Quad;
		
		public function RectangleYDisplay()
		{
			_quad = new Quad(10, 10, 0xFF0000);
			addChild(_quad);
		}
		
		public override function get height():Number { return _quad.height; }
		public override function set height(value:Number):void { _quad.height = value;}
		
		public override function get width():Number { return _quad.width; }
		public override function set width(value:Number):void { _quad.width = value;}
		
		public function get color():Number { return _quad.color; }
		public function set color(value:Number):void { _quad.color = value;}
		
	}
}
