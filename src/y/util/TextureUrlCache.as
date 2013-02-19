package y.util
{
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.events.IOErrorEvent;
	import starling.textures.Texture;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class TextureUrlCache
	{
		private static var textureCache : Dictionary = new Dictionary();
		private static var loaderContext : LoaderContext = new LoaderContext(true);
		{
			loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
		}

		public static function load(string : String, callback : Function) : void
		{			
			if (textureCache[string])
			{
				callback(textureCache[string]);
				return;
			}
			var imageLoader : Loader = new Loader();
			imageLoader.load(new URLRequest(string), loaderContext);
			imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e : Object) : void
			{
			});
			imageLoader.contentLoaderInfo.addEventListener("complete", function(e : Object) : void
			{
				var bitmap : Bitmap = e["target"]["content"] as Bitmap;
				var texture : Texture = Texture.fromBitmap(bitmap, false, false);
				textureCache[string] = texture;
				callback(texture);
			});
		}
	}
}
