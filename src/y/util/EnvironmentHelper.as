package y.util
{
	import flash.system.Capabilities;
	import y.controls.YApplication;

	[Bindable]
	public class EnvironmentHelper
	{
		public static function get isAir(): Boolean
		{
			return Capabilities.playerType == "Desktop";
		}

		public static function get width() : Number
		{
			return isAir ? YApplication.instance.stage.fullScreenWidth : YApplication.instance.fixedWidth;
		}
		
		public static function get height() : Number
		{
			return isAir ? YApplication.instance.stage.fullScreenHeight : YApplication.instance.fixedHeight;
		}
	}
}
