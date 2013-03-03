package y.controls
{
	import flash.events.Event;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;

	import flash.utils.setTimeout;

	[Event(name="show", type="flash.events.Event")]
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
				dispatchEvent(new Event("show"));
			}
			else
			{
				tween.moveTo(-480, y);
			}
			tween.transition = Transitions.EASE_IN_OUT;
			if(Starling.juggler != null)
				Starling.juggler.add(tween);
			setTimeout(function() : void
			{
				uie.visible = value;
			}, duration);
		}
	}
}
