package y.util
{
	import starling.core.Starling;

	import y.controls.YApplication;

	public class YMXMLHelper
	{
		public static function prepareImages() : void
		{
			if (YApplication.instance.starlingInitialized)
				DynamicTextureAtlas.insertAllEmbedds();
			else
			{
				YApplication.instance.addEventListener("starlingInitialized", function(e : Object) : void
				{
					e;
					DynamicTextureAtlas.insertAllEmbedds();
				});
			}
		}

		public static function tryMoveFrames() : void
		{
			var starling : Starling = YApplication.instance.starling;
			starling.nextFrame();
			starling.nextFrame();
		}

		public static function startStop(active : Boolean) : void
		{
			var starling : Starling = YApplication.instance.starling;
			if (starling && active && !starling.isStarted)
				starling.start();
			if (starling && !active && starling.isStarted)
			{
				starling.nextFrame();
				starling.nextFrame();
				starling.stop();
			}
		}
	}
}
