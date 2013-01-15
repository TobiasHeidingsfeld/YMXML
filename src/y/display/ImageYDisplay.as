package y.display
{
	import y.controls.YApplication;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	import y.theme.DynamicTextureAtlas;

	import flash.utils.setTimeout;

	public class ImageYDisplay extends Sprite
	{
		private var _image : Image;
		protected var _source : Object;
		protected var _imageWidth : Number;
		protected var _imageHeight : Number;
		protected var _textureAtlasName : String;

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
					throw new Error("implement String Url loading");
			}
			else
			{
				_textureAtlasName = DynamicTextureAtlas.instance.addEmbeddedImage(_source);
				createImageIfReady();
			}
		}

		public function get source() : Object
		{
			return _source;
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
			if (_image != null)
			{
				removeChild(_image);
				_image = null;
			}

			if (_textureAtlasName == null)
				return;

			createImage();

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
