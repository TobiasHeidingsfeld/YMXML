package y.effect
{
	import y.effect.EffectBase;

	public class AnimateEffect extends EffectBase
	{
		public var valueTo : Number;
		public var property : String;
		
		override protected function addTweens() : void
		{
			tween.animate(property, valueTo);
		}
	}
}
