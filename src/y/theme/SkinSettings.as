package y.theme
{
	import feathers.core.DisplayListWatcher;

	[DefaultProperty("skinSettings")]
	public class SkinSettings
	{
		public var forClass : Class;
		public var withName : String = null;
		private var _skinSettings : Array;

		public function set skinSettings(content : Array) : void
		{
			_skinSettings = content;
		}

		[ArrayElementType("y.theme.ISkinSetting")]
		public function get skinSettings() : Array
		{
			return _skinSettings;
		}

		public function apply(displayWatcher : DisplayListWatcher) : void
		{
			for each (var skinSetting : ISkinSetting in _skinSettings)
				skinSetting.initialize();
			displayWatcher.setInitializerForClass(forClass, handleItem, withName);
		}

		private function handleItem(item : Object) : void
		{
			for each (var skinSetting : ISkinSetting in _skinSettings)
				skinSetting.apply(item);
		}
	}
}
