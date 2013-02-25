package y.controls
{
	import starling.core.Starling;

	import y.display.ImageYDisplay;

	import flash.events.Event;
	import flash.utils.setTimeout;

	public class YImage extends YDisplayObject
	{
		private const READY_EVENT : String = "ready";
		private var proxyObject : DynamicDisplayObject;
		private var preSetProperties : Object;

		override protected function createUIE() : void
		{
			if (Starling.current && Starling.current.context)
				createImage();
			else
			{
				preSetProperties = new Object();
				uie = proxyObject = new DynamicDisplayObject();
				YApplication.instance.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated);
			}
		}

		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			if (t || type == READY_EVENT)
				super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			else if(type != READY_EVENT)
				addEventListener(READY_EVENT, function() : void
				{
					addEventListener(type, listener, useCapture, priority, useWeakReference);
				});
		}

		private function handleContextCreated(event : *) : void
		{
			YApplication.instance.removeEventListener(event["type"], handleContextCreated);
			setTimeout(createImage, 1);
		}

		private function createImage() : void
		{
			uie = new ImageYDisplay();
			fromProxyObject();
			dispatchEvent(new Event(READY_EVENT));
		}

		private function fromProxyObject() : void
		{
			if (proxyObject)
			{
				proxyObject.parent.addChildAt(t, proxyObject.parent.getChildIndex(proxyObject));
				for (var key : String in proxyObject)
					uie[key] = proxyObject[key];
				for (key in preSetProperties)
					uie[key] = preSetProperties[key];
			}
		}

		override public function setProperty(string : String, value : Number) : void
		{
			if (t != null)
				super.setProperty(string, value);
			else
				preSetProperties[string] = value;
		}

		public function get t() : ImageYDisplay
		{
			return uie as ImageYDisplay;
		}

		public function get source() : Object
		{
			return uie["source"];
		}

		public function set source(value : Object) : void
		{
			uie["source"] = value;
		}
		
		public function get repeat() : Boolean
		{
			return uie["repeat"];
		}

		public function set repeat(value : Boolean) : void
		{
			uie["repeat"] = value;
		}
	}
}
import starling.display.Sprite;

dynamic class DynamicDisplayObject extends Sprite
{
}