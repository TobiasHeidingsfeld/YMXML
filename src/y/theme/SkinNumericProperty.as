package y.theme
{

	public class SkinNumericProperty implements ISkinSetting
	{
		public var property : String;
		public var value : Number;
		
		public function initialize() : void
		{
		}

		public function apply(item : Object) : void
		{
			item[property] = value;
		}
	}
}
