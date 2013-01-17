package y.effect
{

	public class Scale extends EffectBase
	{
		private var _scale : Number;
		public var scaleFrom : Number;
		
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
			if(!isNaN(scaleFrom))
				target["scaleX"] = target["scaleY"] = scaleFrom;
			tween.animate("scaleX", scale);
			tween.animate("scaleY", scale);
		}
	}
}
