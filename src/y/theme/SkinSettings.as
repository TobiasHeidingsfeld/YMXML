package y.theme
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.controls.Slider;
	import feathers.controls.TextInput;
	import feathers.core.DisplayListWatcher;

	import y.controls.YButton;
	import y.controls.YLabel;
	import y.controls.YPanel;
	import y.controls.YProgressBar;
	import y.controls.YSlider;
	import y.controls.YTextInput;
	import y.display.PanelDisplay;

	import flash.utils.Dictionary;

	[DefaultProperty("skinSettings")]
	public class SkinSettings
	{
		private static var classMapping : Dictionary = new Dictionary();
		{
			classMapping[YButton] = Button;
			classMapping[YLabel] = Label;
			classMapping[YPanel] = PanelDisplay;
			classMapping[YTextInput] = TextInput;
			classMapping[YSlider] = Slider;
			classMapping[YProgressBar] = ProgressBar;			
		}
		
		public var forClass : Class;
		public var withName : String = null;
		public var andSubclasses : Boolean;
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
			if(classMapping[forClass] != null)
				forClass = classMapping[forClass];
			for each (var skinSetting : ISkinSetting in _skinSettings)
				skinSetting.initialize();
			if(andSubclasses)
				displayWatcher.setInitializerForClassAndSubclasses(forClass, handleItem);
			else
				displayWatcher.setInitializerForClass(forClass, handleItem, withName);
		}

		private function handleItem(item : Object) : void
		{
			for each (var skinSetting : ISkinSetting in _skinSettings)
				skinSetting.apply(item);
		}
	}
}
