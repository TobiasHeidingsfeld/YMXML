package y.controls
{
	import flash.utils.setTimeout;
	import starling.core.Starling;
	import starling.events.Event;

	import y.display.ImageYDisplay;

	public class YImage extends YDisplayObject
	{
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

		private function handleContextCreated(event : *) : void
		{
			YApplication.instance.removeEventListener(event["type"], handleContextCreated);
			setTimeout(createImage, 1);
		}

		private function createImage() : void
		{
			uie = new ImageYDisplay();
			fromProxyObject();			
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
			if(t != null)
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
	}
}
import starling.display.Sprite;

dynamic class DynamicDisplayObject extends Sprite 
{
}