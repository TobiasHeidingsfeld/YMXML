package y.util
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.Event;

	public class OnDemandEventDispatcher implements IEventDispatcher
	{
		private var dispatcher : EventDispatcher;
		
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			if(!dispatcher)
				dispatcher = new EventDispatcher();
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			if(dispatcher)
				dispatcher.removeEventListener(type, listener, useCapture);
		}

		public function dispatchEvent(event : Event) : Boolean
		{
			if(dispatcher)
				return dispatcher.dispatchEvent(event);
			return false;
		}

		public function hasEventListener(type : String) : Boolean
		{
			if(dispatcher)
				return dispatcher.hasEventListener(type);
			return false;
		}

		public function willTrigger(type : String) : Boolean
		{
			if(dispatcher)
				return dispatcher.willTrigger(type);
			return false;
		}
	}
}
