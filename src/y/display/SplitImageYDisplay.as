package y.display
{
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	import y.theme.DynamicTextureAtlas;



	public class SplitImageYDisplay extends ImageYDisplay
	{
		private var _imageSplits : Array;
		
		public function get imageSplits() : Array
		{
			return _imageSplits;
		}

		public function set imageSplits(imageSplits : Array) : void
		{
			this._imageSplits = imageSplits;
		}

		override protected function createImage() : void
		{
			removeChildren();
			_images = [];
			var texture : Texture = DynamicTextureAtlas.instance.getTexture(_textureAtlasName);
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
	}
}
