package y.util
{
	import flash.events.Event;
	import ru.etcs.utils.getDefinitionNames;

	import starling.core.Starling;

	import y.controls.YApplication;

	import flash.utils.describeType;

	public class YMXMLHelper
	{
		public static function prepareImages() : void
		{
			if (YApplication.instance.onStage)
				insertAllEmbedds();
			else
				YApplication.instance.addEventListener(YApplication.STARLING_INITIALIZED, insertAllEmbedds);			
		}
		
		private static function insertAllEmbedds(event : Event = null) : void
		{	
			if(DynamicTextureAtlas.instance.preCreatedBitmapData != null)
				return;
					
			for each (var defName : String in (getDefinitionNames(YApplication.instance.loaderInfo, false, true)))
			{
				var classDef : Class = YApplication.instance.loaderInfo.applicationDomain.getDefinition(defName) as Class;
				var info : String = describeType(classDef) + "";
				if (info.indexOf("mx.core::BitmapAsset") >= 0 && YApplication.instance.theme.backgroundImage != classDef && info.indexOf("NTA") == -1)
				{
					DynamicTextureAtlas.instance.addEmbeddedImage(classDef);
				}
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
