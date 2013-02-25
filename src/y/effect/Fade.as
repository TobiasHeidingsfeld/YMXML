package y.effect
{
	public class Fade extends EffectBase
	{
		private var _alpha : Number;
		private var _fromAlpha : Number;
		
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
			if(!isNaN(fromAlpha))
				target["alpha"] = fromAlpha;			
			tween.fadeTo(alpha);
		}

		public function get fromAlpha() : Number
		{
			return _fromAlpha;
		}

		public function set fromAlpha(fromAlpha : Number) : void
		{
			this._fromAlpha = fromAlpha;
			checkAutoPlay();
		}
	}
}
