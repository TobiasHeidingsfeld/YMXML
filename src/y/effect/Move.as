package y.effect
{
	public class Move extends EffectBase
	{
		private var _x : int;
		private var _y : int;
		private var _fromX : Number;
		private var _fromY : Number;

		public function get x() : int
		{
			return _x;
		}

		public function set x(x : int) : void
		{
			this._x = x;
			checkAutoPlay();
		}

		public function get y() : int
		{
			return _y;
		}

		public function set y(y : int) : void
		{
			this._y = y;
			checkAutoPlay();
		}

		override protected function addTweens() : void
		{			
			if(!isNaN(fromX))
				target["x"] = fromX;
			if(!isNaN(fromY))
				target["y"] = fromY;
			tween.moveTo(_x, _y);
		}

		public function get fromX() : Number
		{
			return _fromX;
		}

		public function set fromX(fromX : Number) : void
		{
			this._fromX = fromX;
			checkAutoPlay();
		}

		public function get fromY() : Number
		{
			return _fromY;
		}

		public function set fromY(fromY : Number) : void
		{
			this._fromY = fromY;
			checkAutoPlay();
		}
	}
}
