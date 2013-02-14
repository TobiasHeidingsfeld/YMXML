package y.util
{
	import flash.events.IOErrorEvent;
	import starling.textures.Texture;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class TextureUrlCache
	{
		private static var textureCache : Dictionary = new Dictionary();

		public static function load(string : String, callback : Function) : void
		{			
			if (textureCache[string])
			{
				//setTimeoutStarling(callback, 350, textureCache[string]);
				callback(textureCache[string]);
				return;
			}
			var imageLoader : Loader = new Loader();
			imageLoader.load(new URLRequest(string));
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
