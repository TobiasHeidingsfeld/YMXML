package y.effect
{

	public class Scale extends EffectBase
	{
		private var _scale : Number;
		public function get scale() : Number
		{
			return _scale;
		}

		public function set scale(value : Number) : void
		{
			this._scale = value;
			checkAutoPlay();
		}
		
		override protected function addTweens() : void
		{
			super.addTweens();
			tween.scaleTo(_scale);
		}
	}
}
