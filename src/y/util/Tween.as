package y.util
{
	import starling.animation.IAnimatable;
	import starling.animation.Tween;
	import starling.core.Starling;

	import y.controls.YApplication;

	import flash.events.Event;

	public class Tween extends starling.animation.Tween
	{
		public function Tween(target : Object, time : Number, transition : Object = "linear")
		{
			super(target, time, transition);
			var me : IAnimatable = this;
			if (Starling.juggler)
				Starling.juggler.add(me);
			else
				YApplication.instance.addEventListener(Event.CONTEXT3D_CREATE, function(event : Event) : void
				{
					Starling.juggler.add(me);
				});
		}

		public function stop() : void
		{
			Starling.juggler.remove(this);
		}
	}
}
