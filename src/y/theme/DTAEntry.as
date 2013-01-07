package y.theme
{
	import mx.core.BitmapAsset;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	public class DTAEntry
	{
		public var image : Object;
		public var name : String;
		public var atlasUsedRectangle : Rectangle;
		public var bitmapData : BitmapData;

		public function DTAEntry(image : Object = null, name : String = null)
		{
			this.name = name;
			this.image = image;
			if(image)
				bitmapData = (new image() as BitmapAsset).bitmapData;
		}
	}
}
