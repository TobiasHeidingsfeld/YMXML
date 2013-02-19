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
		
		public static function get isADL(): Boolean
		{
			return isAir && Capabilities.os.toLowerCase().indexOf("windows") >= 0;
		}
		
		public static function get isiOS(): Boolean
		{
			return isAir && Capabilities.manufacturer.indexOf("iOS") != -1;
		}

		public static function get width() : Number
		{
			if(YApplication.instance.stage == null)
				return 0;
			return isAir ? YApplication.instance.stage.fullScreenWidth : YApplication.instance.stage.stageWidth;
		}
		
		public static function get height() : Number
		{
			if(YApplication.instance.stage == null)
				return 0;
			return isAir ? YApplication.instance.stage.fullScreenHeight : YApplication.instance.stage.stageHeight;
		}
	}
}
