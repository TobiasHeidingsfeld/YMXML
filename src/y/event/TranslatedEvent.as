package y.event
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;


	public class TranslatedEvent
	{
		public static var translatedEvents : Array = [];
		{
		new TranslatedEvent(starling.events.Event.ENTER_FRAME, flash.events.Event.ENTER_FRAME);
		
		new TranslatedEvent(starling.events.Event.ADDED_TO_STAGE, flash.events.Event.ADDED_TO_STAGE);
		
		new TranslatedEvent(starling.events.Event.REMOVED_FROM_STAGE, flash.events.Event.REMOVED_FROM_STAGE);
		
		new TranslatedEvent(starling.events.Event.CHANGE, flash.events.Event.CHANGE);
		
		new TranslatedEvent(starling.events.Event.TRIGGERED, MouseEvent.CLICK, function(event : starling.events.Event) : Object
		{
			event;
			return new MouseEvent(MouseEvent.CLICK);
		});
		
		new TranslatedEvent(starling.events.KeyboardEvent.KEY_DOWN, flash.events.KeyboardEvent.KEY_DOWN, function(event : starling.events.KeyboardEvent) : Object
		{
			return new flash.events.KeyboardEvent(flash.events.KeyboardEvent.KEY_DOWN, true, false, event.charCode, event.keyCode, event.keyLocation, event.ctrlKey, event.altKey, event.shiftKey);
		});
		
		new TranslatedEvent(starling.events.KeyboardEvent.KEY_UP, flash.events.KeyboardEvent.KEY_UP, function(event : starling.events.KeyboardEvent) : Object
		{
			return new flash.events.KeyboardEvent(flash.events.KeyboardEvent.KEY_UP, true, false, event.charCode, event.keyCode, event.keyLocation, event.ctrlKey, event.altKey, event.shiftKey);
		});
		
		new TranslatedEvent(TouchEvent.TOUCH, TranslatedTouchEvent.DRAG, function(event : TouchEvent) : Object
		{
			if (event.touches[0].phase == TouchPhase.MOVED)
				return new TranslatedTouchEvent(TranslatedTouchEvent.DRAG ,event);
			return null;
		});
		
		new TranslatedEvent(TouchEvent.TOUCH, TranslatedTouchEvent.TOUCH, function(event : TouchEvent) : Object
		{
			return new TranslatedTouchEvent(TranslatedTouchEvent.TOUCH ,event);			
		});
		
		new TranslatedEvent(TouchEvent.TOUCH, MouseEvent.MOUSE_OVER, function(event : TouchEvent, state : *) : Object
		{
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.HOVER))
			{
				if (state["h"])
					return null;
				state["h"] = true;
				return new MouseEvent(MouseEvent.MOUSE_DOWN);
			}
			state["h"] = false;
			return null;
		});
		
		new TranslatedEvent(TouchEvent.TOUCH, MouseEvent.MOUSE_OUT, function(event : TouchEvent, state : *) : Object
		{
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.HOVER) == null)
			{
				if (state["h"])
					return null;
				state["h"] = true;
				return new MouseEvent(MouseEvent.MOUSE_DOWN);
			}
			state["h"] = false;
			return null;
		});
		
		new TranslatedEvent(TouchEvent.TOUCH, MouseEvent.MOUSE_DOWN, function(event : TouchEvent) : Object
		{
			if (event.touches[0].phase == TouchPhase.BEGAN)
			{
				var location : Point = event.touches[0].getLocation(event.currentTarget as DisplayObject);
				return new MouseEvent(MouseEvent.MOUSE_DOWN, true, false, location.x, location.y);
			}
			return null;
		});
		
		new TranslatedEvent(TouchEvent.TOUCH, MouseEvent.MOUSE_MOVE, function(event : TouchEvent) : Object
		{
			if (event.touches[0].phase == TouchPhase.HOVER || event.touches[0].phase == TouchPhase.MOVED)
			{
				var location : Point = event.touches[0].getLocation(event.currentTarget as DisplayObject);
				return new MouseEvent(MouseEvent.MOUSE_MOVE, true, false, location.x, location.y);
			}
			return null;
		});
		
		new TranslatedEvent(TouchEvent.TOUCH, MouseEvent.MOUSE_UP, function(event : TouchEvent) : Object
		{
			if (event.touches[0].phase == TouchPhase.ENDED)
				return new MouseEvent(MouseEvent.MOUSE_UP);
			return null;
		});
		}
		private var starlingEvent : String;
		private var event : String;
		private var eventTranslation : Function;

		public function TranslatedEvent(starlingEvent : String, event : String, eventTranslation : Function = null)
		{
			if (eventTranslation == null)
			{
				eventTranslation = function(argStarlingEvent : starling.events.Event) : Object
				{
					argStarlingEvent;
					return new flash.events.Event(event);
				};
			}
			this.eventTranslation = eventTranslation;
			this.event = event;
			this.starlingEvent = starlingEvent;
			translatedEvents[event] = this;
		}

		public function create(listener : Function, uie : Sprite) : void
		{
			if (eventTranslation.length == 2)
			{
				var state : * = {};
				var newListenerFunction : Function = function(starlingEvent : starling.events.Event) : void
				{
					var newEvent : Object = eventTranslation(starlingEvent, state);
					if (newEvent != null)
						listener(newEvent);
				};
			}
			else
			{
				newListenerFunction = function(starlingEvent : starling.events.Event) : void
				{
					var newEvent : Object = eventTranslation(starlingEvent);
					if (newEvent != null)
						listener(newEvent);
				};
			}
			uie.addEventListener(starlingEvent, newListenerFunction);
		}

		public function remove(listener : Function, uie : Sprite) : void
		{
			// bei add ein "dicionary oder ähnliches mit dem orginal eventlisterner und dem  newListenerFunction und so die newListenerFunction bekommen und beim uie abmelden und den eintrag im dictionary entfernen
		}
	}
}
