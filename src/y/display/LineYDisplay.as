package y.display
{
	import starling.display.Quad;
	import starling.display.Sprite;

	public class LineYDisplay extends Sprite
	{
		private var _baseQuad : Quad;
		private var _thickness : Number = 1;
		private var _color : uint = 0x000000;
		private var _toX : int;
		private var _toY : int;

		public function LineYDisplay()
		{
			_baseQuad = new Quad(1, _thickness, _color);
			addChild(_baseQuad);			
		}

		public function lineTo() : void
		{
			var toX2 : int = toX - this.x;
			var toY2 : int = toY - this.y;
			_baseQuad.rotation = 0;
			_baseQuad.width = Math.round(Math.sqrt((toX2 * toX2) + (toY2 * toY2)));
			_baseQuad.rotation = Math.atan2(toY2, toX2);
		}

		public function set thickness(t : Number) : void
		{
			var currentRotation : Number = _baseQuad.rotation;
			_baseQuad.rotation = 0;
			_baseQuad.height = _thickness = t;
			_baseQuad.rotation = currentRotation;
		}

		public function get thickness() : Number
		{
			return _thickness;
		}

		public function set color(c : uint) : void
		{
			_baseQuad.color = _color = c;			
		}

		public function get color() : uint
		{
			return _color;
		}

		public function get toX() : int
		{
			return _toX;
		}

		public function set toX(toX : int) : void
		{
			this._toX = toX;
			lineTo();
		}

		public function get toY() : int
		{
			return _toY;
		}

		public function set toY(toY : int) : void
		{
			this._toY = toY;
			lineTo();
		}
	}
}
