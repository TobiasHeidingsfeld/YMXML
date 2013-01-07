package y.theme
{
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import starling.textures.Texture;
	import y.controls.YApplication;




	public class SkinGradient implements ISkinSetting
	{
		public var skinName : String;
		public var color : int = YApplication.instance.theme.chromeColor;
		public var roundRect : int = 5;
		public var borderThickness : int = 1;
		public var borderColor : int = 0x000000;
		public var size : int = 16;
		
		private var _texture : Texture;
		private var rectangle : Rectangle;

		public function initialize() : void
		{
			createTexture();
			var padding : int = roundRect + borderThickness + 1;
			rectangle = new Rectangle(padding, padding, size - padding * 2, size - padding * 2);			
		}

		public function apply(item : Object) : void
		{
			item[skinName] = new Scale9Image(new Scale9Textures(_texture, rectangle));			
		}

		private function createTexture() : void
		{
			var sprite : Sprite = new Sprite();
			sprite.graphics.beginFill(borderColor);
			sprite.graphics.drawRoundRect(0, 0, size, size, roundRect);
			sprite.graphics.endFill();
			
			sprite.graphics.beginGradientFill("linear", [color, color - 0x333333], [100,100], [0,255]);
			sprite.graphics.drawRoundRect(borderThickness, borderThickness, size - borderThickness * 2, size - borderThickness * 2, roundRect);
			sprite.graphics.endFill();
			
			var bitmap : BitmapData = new BitmapData(size, size, true, 0x00FFFFFF);
			bitmap.draw(sprite);
			_texture = Texture.fromBitmapData(bitmap);
		}
	}
}
