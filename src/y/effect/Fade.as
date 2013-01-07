package y.effect
{
	public class Fade extends EffectBase
	{
		private var _alpha : Number;
		
		public function get alpha() : Number
		{
			return _alpha;
		}

		public function set alpha(value : Number) : void
		{
			this._alpha = value;
			checkAutoPlay();
		}
		
		override protected function addTweens() : void
		{			
			tween.fadeTo(alpha);
		}
	}
}
