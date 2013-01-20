package y.event
{
	import starling.events.TouchEvent;
	import flash.events.Event;

	public class TranslatedTouchEvent extends Event
	{
		public static const DRAG : String = "drag";
		public static const TOUCH : String = "touch";
		public var touchEvent : TouchEvent;

		public function TranslatedTouchEvent(type : String, touchEvent : TouchEvent)
		{
			this.touchEvent = touchEvent;
			super(type);
		}
	}
}
