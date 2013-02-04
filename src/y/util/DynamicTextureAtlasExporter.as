package y.util
{
	import flash.utils.ByteArray;
	import flash.net.FileReference;
	import mx.graphics.codec.PNGEncoder;
	public class DynamicTextureAtlasExporter
	{
		public static function export(): void
		{
			var encoder : PNGEncoder = new PNGEncoder();
			var bytes : ByteArray = encoder.encode(DynamicTextureAtlas.instance.generateBitmapData());
			new FileReference().save(bytes, "Atlas.png");
		}
		
		public static function exportInfo(): void
		{			
			new FileReference().save(JSON.stringify(DynamicTextureAtlas.instance.entries), "AtlasInfo.txt");
		}
	}
}
