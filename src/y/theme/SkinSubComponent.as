package y.theme
{
	[DefaultProperty("skinSettings")]
	public class SkinSubComponent implements ISkinSetting
	{
		public var name : String;
		
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

		public function apply(item : Object) : void
		{
			var subcomponent : Object = item[name];
			for each (var skinSetting : ISkinSetting in _skinSettings)
				skinSetting.apply(subcomponent);
		}

		public function initialize() : void
		{
			for each (var skinSetting : ISkinSetting in _skinSettings)
				skinSetting.initialize();
		}
	}
}
