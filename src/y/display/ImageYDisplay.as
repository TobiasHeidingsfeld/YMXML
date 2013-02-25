package y.display
{
	import starling.display.Image;
	import starling.textures.Texture;

	import y.util.DynamicTextureAtlas;
	import y.util.TextureUrlCache;

	import flash.display.BitmapData;

	public class ImageYDisplay extends Image
	{
		private static var EMTPY_TEXTURE : Texture;
		protected var _source : Object;
		private var _setWidth : Number;
		private var _setHeight : Number;
		private var _repeat : Boolean;

		public function ImageYDisplay(value : Object = null)
		{
			if (EMTPY_TEXTURE == null)
				EMTPY_TEXTURE = Texture.fromBitmapData(new BitmapData(1, 1, true, 0x00FFFFFF));
			super(EMTPY_TEXTURE);
			source = value;
		}

		public function set source(value : Object) : void
		{
			_source = value;
			if (value is Class || value is String)
			{
				if (value is String)
				{
					var string : String = value as String;
					if (DynamicTextureAtlas.instance.getTexture(string))
						setNewTexture(DynamicTextureAtlas.instance.getTexture(string));
					else
						loadImage(string);
				}
				else
				{
					var textureAtlasName : String = DynamicTextureAtlas.instance.addEmbeddedImage(_source);
					setNewTexture(DynamicTextureAtlas.instance.getTexture(textureAtlasName));
				}
			}
			else
				setNewTexture(EMTPY_TEXTURE);
		}

		private function loadImage(string : String) : void
		{
			TextureUrlCache.load(string, setNewTexture);
		}

		public function get source() : Object
		{
			return _source;
		}

		private function setNewTexture(newTexture : Texture) : void
		{
			if (texture == newTexture)
				return;
			texture = newTexture;
			setRepeat();
			readjustSize();
			if (!isNaN(_setWidth))
				width = _setWidth;
			if (!isNaN(_setHeight))
				height = _setHeight;
		}

		override public function set width(value : Number) : void
		{
			super.width = value;
			_setWidth = value;
		}

		override public function set height(value : Number) : void
		{
			super.height = value;
			_setHeight = value;
		}

		public function get repeat() : Boolean
		{
			return _repeat;
		}

		public function set repeat(repeat : Boolean) : void
		{
			this._repeat = repeat;
			setRepeat();
		}

		private function setRepeat() : void
		{
			// if(texture is SubTexture)
			// setNewTexture(texture.)
			texture.repeat = _repeat;
		}
	}
}
