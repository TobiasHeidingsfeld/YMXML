package y.theme
{

	public class SkinPadding implements ISkinSetting
	{
		public var value : Number = 5;

		public function initialize() : void
		{
		}

		public function apply(item : Object) : void
		{
			for each (var property : String in ["paddingTop", "paddingBottom", "paddingLeft", "paddingRight"])
				item[property] = value;
		}
	}
}
