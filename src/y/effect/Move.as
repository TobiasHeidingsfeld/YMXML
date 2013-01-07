package y.effect
{
	public class Move extends EffectBase
	{
		private var _x : int;
		private var _y : int;

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
			tween.moveTo(_x, _y);
		}
	}
}
