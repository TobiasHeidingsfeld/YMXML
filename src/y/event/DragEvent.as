package y.event
{
	import starling.events.TouchEvent;
	import flash.events.Event;

	public class DragEvent extends Event
	{
		public static const DRAG : String = "drag";
		public var touchEvent : TouchEvent;

		public function DragEvent(touchEvent : TouchEvent)
		{
			this.touchEvent = touchEvent;
			super(DRAG);
		}
	}
}
