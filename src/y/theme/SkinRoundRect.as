package y.theme
{
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import starling.textures.Texture;
	import y.controls.YApplication;

	public class SkinRoundRect implements ISkinSetting
	{
		public var skinName : String;
		public var color : uint = YApplication.instance.theme.chromeColor;
		public var roundRect : int = 5;
		public var borderThickness : int = 1;
		public var borderColor : int = 0x333333;
		public var borderAlpha : Number = 1;
		public var size : int = 16;
		private var _texture : Texture;
		private var rectangle : Rectangle;

		public function initialize() : void
		{
			createTexture();
			var scale9Padding : int = roundRect + borderThickness + 1;
			rectangle = new Rectangle(scale9Padding, scale9Padding, size - scale9Padding * 2, size - scale9Padding * 2);
		}

		public function apply(item : Object) : void
		{
			item[skinName] = new Scale9Image(new Scale9Textures(_texture, rectangle));
		}

		private function createTexture() : void
		{
			var sprite : Sprite = new Sprite();
			sprite.graphics.beginFill(borderColor, borderAlpha);
			sprite.graphics.drawRoundRect(0, 0, size, size, roundRect);
			sprite.graphics.endFill();

			var fillSize : int = size - borderThickness * 2;
			sprite.graphics.beginFill(color);
			sprite.graphics.drawRoundRect(borderThickness, borderThickness, fillSize, fillSize, roundRect);
			sprite.graphics.endFill();

			var bitmap : BitmapData = new BitmapData(size, size, true, 0x00FFFFFF);
			bitmap.draw(sprite);
			_texture = Texture.fromBitmapData(bitmap);
		}
	}
}
