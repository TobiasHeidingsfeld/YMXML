package y.util
{
	import flash.utils.Dictionary;

	import starling.textures.Texture;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;

	public class TextureUrlCache
	{
		private static var textureCache : Dictionary = new Dictionary();

		public static function load(string : String, callback : Function) : void
		{
			if (textureCache[string])
			{
				setTimeoutStarling(callback, 50, textureCache[string]);
				return;
			}
			var imageLoader : Loader = new Loader();
			imageLoader.load(new URLRequest(string));
			imageLoader.contentLoaderInfo.addEventListener("complete", function(e : Object) : void
			{
				var bitmap : Bitmap = e["target"]["content"] as Bitmap;
				var texture : Texture = Texture.fromBitmap(bitmap, true, true);
				textureCache[string] = texture;
				callback(texture);
			});
		}
	}
}
