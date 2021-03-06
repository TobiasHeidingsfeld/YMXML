package y.theme
{
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import y.util.DynamicTextureAtlas;

	public class SkinImage implements ISkinSetting
	{
		public var skinName : String;
		public var image : Object;
		public var scale9 : String;
		private var _textureAtlasName : String;
		private var _scale9Grid : Rectangle;
		private var _scale9Textures : Scale9Textures;
		
		public function initialize() : void
		{
			prepareTexture();
		}

		public function apply(item : Object) : void
		{
			if(_textureAtlasName == null)
				item[skinName] = null;
			else if(_scale9Grid == null)	
				item[skinName] = new Image(DynamicTextureAtlas.instance.getTexture(_textureAtlasName));
			else 
				item[skinName] = new Scale9Image(_scale9Textures);
		}

		public function prepareTexture() : void
		{
			if(image == null)
				return;
			_textureAtlasName = DynamicTextureAtlas.instance.addEmbeddedImage(image);
			if (scale9 != null)
			{
				var props : Array = scale9.split(",");
				_scale9Grid = new Rectangle(parseInt(props[0]), parseInt(props[1]), parseInt(props[2]), parseInt(props[3]));
				_scale9Textures = new Scale9Textures(DynamicTextureAtlas.instance.getTexture(_textureAtlasName), _scale9Grid);
			}
		}
	}
}
