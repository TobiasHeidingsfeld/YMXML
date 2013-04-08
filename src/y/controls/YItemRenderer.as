package y.controls
{
	import flash.events.Event;
	
	[Event(name="preDataChange", type="flash.events.Event")]
	[Event(name="dataChange", type="flash.events.Event")]
	public class YItemRenderer extends YSprite
	{
		public var typedObjectName : String = "typedObject";
		private var _data : Object;

		[Bindable(event="dataChange")]
		public function get data() : Object
		{
			return _data;
		}

		public function set data(value : Object) : void
		{
			dispatchEvent(new Event("preDataChange"));
			_data = value;
			try
			{
				if (hasOwnProperty(typedObjectName))
					this[typedObjectName] = value;
			}
			catch(error : Error)
			{
			}
			dispatchEvent(new Event("dataChange"));
		}
	}
}
