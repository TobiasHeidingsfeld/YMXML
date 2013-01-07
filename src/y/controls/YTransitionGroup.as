package y.controls
{
	import flash.utils.setTimeout;
	import starling.animation.Tween;
	import starling.core.Starling;


	public class YTransitionGroup extends YGroup
	{
		public var duration : int = 500;

		override public function set visible(value : Boolean) : void
		{
			var tween : Tween = new Tween(uie, duration / 1000);
			if(value)
			{
				x = 480;
				tween.moveTo(0, y);
				uie.visible = true;
			}
			else
			{
				tween.moveTo(-480, y);
			}
			if(Starling.juggler != null)
				Starling.juggler.add(tween);
			setTimeout(function() : void
			{
				uie.visible = value;
			}, duration);
		}
	}
}
