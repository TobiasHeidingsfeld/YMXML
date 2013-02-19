package y.display
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import y.util.DynamicTextureAtlas;

	import flash.geom.Rectangle;

	public class SplitImageYDisplay extends Sprite
	{
		private var _imageSplits : Array;
		private var _source : Object;
		
		public function get imageSplits() : Array
		{
			return _imageSplits;
		}

		public function set imageSplits(imageSplits : Array) : void
		{
			this._imageSplits = imageSplits;
		}

		protected function createImages() : void
		{
			removeChildren();
			_images = [];
			var textureAtlasName : String;
			var texture : Texture = DynamicTextureAtlas.instance.getTexture(textureAtlasName);
			for each (var split : Rectangle in _imageSplits)
			{
				var image : Image = new Image(Texture.fromTexture(texture, split));
				image.x = split.x;
				image.y = split.y;
				_images.push(image);
				addChild(image);
			}
		}
		
		private var _images : Array;
		
		public function get imageParts() : Array
		{
			return _images;
		}

		public function get source() : Object
		{
			return _source;
		}

		public function set source(source : Object) : void
		{
			this._source = source;
		}
	}
}
