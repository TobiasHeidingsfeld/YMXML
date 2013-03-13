package y.controls
{
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.filters.FragmentFilter;

	import y.event.TranslatedEvent;
	import y.util.Tween;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	[Event(name="enterFrame", type="flash.events.Event")]
	[Event(name="mouseDown", type="flash.events.MouseEvent")]
	[Event(name="mouseUp", type="flash.events.MouseEvent")]
	[Event(name="mouseOver", type="flash.events.MouseEvent")]
	[Event(name="mouseOut", type="flash.events.MouseEvent")]
	[Event(name="mouseMove", type="flash.events.MouseEvent")]
	[Event(name="addedToStage", type="flash.events.Event")]
	[Event(name="removedFromStage", type="flash.events.Event")]
	[Event(name="keyDown", type="flash.events.KeyboardEvent")]
	[Event(name="keyUp", type="flash.events.KeyboardEvent")]
	[Event(name="drag", type="y.event.TranslatedTouchEvent")]
	[Event(name="touch", type="y.event.TranslatedTouchEvent")]
	public class YDisplayObject extends EventDispatcher
	{
		public var transitionDuration : int;
		public var transitionDelay : int;
		protected var uie : DisplayObject;
		
		public function YDisplayObject()
		{
			createUIE();			
		}

		protected function createUIE() : void
		{
			uie = new DisplayObject();
		}

		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			var translatedEvent : TranslatedEvent = TranslatedEvent.translatedEvents[type];
			if (translatedEvent != null)
				translatedEvent.create(listener, uie);				
			else
				super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		override public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			var translatedEvent : TranslatedEvent = TranslatedEvent.translatedEvents[type];
			if (translatedEvent != null)
				translatedEvent.remove(listener, uie);
			else
				super.removeEventListener(type, listener, useCapture);
		}

		public function getUIE() : DisplayObject
		{
			return uie;
		}

		public function setProperty(string : String, value : Number) : void
		{
			if (transitionDuration > 0)
				animate(uie, string, value, transitionDuration, transitionDelay);
			else
				uie[string] = value;
		}

		public function animate(object : Object, string : String, value : Number, duration : int, delay : int = 0) : Tween
		{
			var tween : Tween = new Tween(object, duration / 1000);
			tween.delay = delay / 1000;
			tween.animate(string, value);
			return tween;
		}

		public function get x() : Number
		{
			return uie.x;
		}

		public function set x(value : Number) : void
		{
			setProperty("x", value);
		}

		public function get y() : Number
		{
			return uie.y;
		}

		public function set y(value : Number) : void
		{
			setProperty("y", value);
		}

		public function get alpha() : Number
		{
			return uie.alpha;
		}

		public function set alpha(value : Number) : void
		{
			setProperty("alpha", value);
		}

		public function get visible() : Boolean
		{
			return uie.visible;
		}

		public function set visible(value : Boolean) : void
		{
			uie.visible = value;
		}

		public function get useHandCursor() : Boolean
		{
			return uie.useHandCursor;
		}

		public function set useHandCursor(value : Boolean) : void
		{
			uie.useHandCursor = value;
		}

		public function get touchable() : Boolean
		{
			return uie.touchable;
		}

		public function set touchable(value : Boolean) : void
		{
			uie.touchable = value;
		}

		public function get rotation() : Number
		{
			return uie.rotation;
		}

		public function set rotation(value : Number) : void
		{
			setProperty("rotation", value / 180 * Math.PI);
		}

		public function get scaleX() : Number
		{
			return uie.scaleX;
		}

		public function set scaleX(value : Number) : void
		{
			setProperty("scaleX", value);
		}

		public function get scaleY() : Number
		{
			return uie.scaleY;
		}

		public function set scaleY(value : Number) : void
		{
			setProperty("scaleY", value);
		}

		public function get pivotX() : Number
		{
			return uie.pivotX;
		}

		public function set pivotX(value : Number) : void
		{
			setProperty("pivotX", value);
		}

		public function get pivotY() : Number
		{
			return uie.pivotY;
		}

		public function set pivotY(value : Number) : void
		{
			setProperty("pivotY", value);
		}

		public function get name() : String
		{
			return uie.name;
		}

		public function set name(value : String) : void
		{
			uie.name = value;
		}

		public function get height() : Number
		{
			return uie.height;
		}

		public function set height(value : Number) : void
		{
			setProperty("height", value);
		}

		public function get skewX() : Number
		{
			return uie.skewX;
		}

		public function set skewX(value : Number) : void
		{
			setProperty("skewX", value);
		}

		public function get skewY() : Number
		{
			return uie.skewY;
		}

		public function set skewY(value : Number) : void
		{
			setProperty("skewY", value);
		}

		public function get width() : Number
		{
			return uie.width;
		}

		public function set width(value : Number) : void
		{
			setProperty("width", value);
		}

		public function get filter() : FragmentFilter
		{
			return uie.filter;
		}

		public function set filter(value : FragmentFilter) : void
		{
			uie.filter = value;
		}
	}
}
