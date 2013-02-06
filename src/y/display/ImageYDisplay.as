package y.display
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import y.controls.YApplication;
	import y.util.DynamicTextureAtlas;
	import y.util.TextureUrlCache;

	import flash.utils.setTimeout;

	public class ImageYDisplay extends Sprite
	{
		protected var _source : Object;
		protected var _imageWidth : Number;
		protected var _imageHeight : Number;
		protected var _textureAtlasName : String;
		protected var _image : Image;
		
		public function set source(value : Object) : void
		{
			_source = value;
			if (value is String)
			{
				var string : String = value as String;
				if (DynamicTextureAtlas.instance.getTexture(string))
				{
					_textureAtlasName = string;
					createImageIfReady();
				}
				else
				{
					loadImage(string);
				}
			}
			else
			{
				_textureAtlasName = DynamicTextureAtlas.instance.addEmbeddedImage(_source);
				createImageIfReady();
			}
		}

		private function loadImage(string : String) : void
		{
			TextureUrlCache.load(string, function(texture : Texture): void
			{
				removeOldImage();				
				_image = new Image(texture);
				addChild(_image);
				updateSize();
			});			
		}

		public function get source() : Object
		{
			return _source;
		}

		public function ImageYDisplay(value : Object = null)
		{
			source = value;
		}

		private function createImageIfReady() : void
		{
			if (Starling.current && Starling.current.context)
				setTimeout(createDisplay, 1);
			else
				YApplication.instance.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated);
		}

		private function handleContextCreated(event : *) : void
		{
			YApplication.instance.removeEventListener(event["type"], handleContextCreated);
			createDisplay();
		}

		protected function createDisplay() : void
		{
			removeOldImage();

			if (_textureAtlasName == null)
				return;

			createImage();
			
			updateSize();
		}

		private function removeOldImage() : void
		{
			if (_image != null)
			{
				removeChild(_image);
				_image = null;
			}
		}

		private function updateSize() : void
		{
			if (!isNaN(_imageWidth))
				width = _imageWidth;
			if (!isNaN(_imageHeight))
				height = _imageHeight;
		}

		protected function createImage() : void
		{
			if (_textureAtlasName != null && _textureAtlasName != "")
			{
				_image = new Image(DynamicTextureAtlas.instance.getTexture(_textureAtlasName));
				addChild(_image);
			}
		}

		override public function set width(value : Number) : void
		{
			if (_image != null)
				_image.width = value;
			super.width = value;
			_imageWidth = value;
		}

		override public function set height(value : Number) : void
		{
			if (_image != null)
				_image.height = value;
			super.height = value;
			_imageHeight = value;
		}
	}
}
