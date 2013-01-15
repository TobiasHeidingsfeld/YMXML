package y.theme
{
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.textures.Texture;

	import y.controls.YApplication;
	import y.util.EnvironmentHelper;

	import mx.core.BitmapAsset;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	public class BackgroundImage
	{
		public function BackgroundImage(backgroundImage : Object)
		{
			var rectMask : Shape = new Shape();
			var viewport : Rectangle = Starling.current.viewPort;
			var scale : Number = Starling.contentScaleFactor;
			var backgroundDisplayObject : BitmapAsset = new (backgroundImage)();
			backgroundDisplayObject.smoothing = true;
			backgroundDisplayObject.scaleX = backgroundDisplayObject.scaleY = scale;
			backgroundDisplayObject.x = (EnvironmentHelper.width - backgroundDisplayObject.width) / 2;
			backgroundDisplayObject.y = (EnvironmentHelper.height - backgroundDisplayObject.height) / 2;
			backgroundDisplayObject.cacheAsBitmap = rectMask.cacheAsBitmap = true;
			YApplication.instance.addChild(backgroundDisplayObject);

			rectMask.cacheAsBitmap = true;
			rectMask.graphics.beginFill(0xFF0000, 1);
			rectMask.graphics.drawRect(backgroundDisplayObject.x, backgroundDisplayObject.y, backgroundDisplayObject.width, backgroundDisplayObject.height);
			rectMask.graphics.drawRect(viewport.x, viewport.y, viewport.width - 1, viewport.height - 1);
			rectMask.graphics.endFill();

			backgroundDisplayObject.mask = rectMask;
			YApplication.instance.addChild(rectMask);

			var starlingBG : BitmapData = new BitmapData(viewport.width / Starling.contentScaleFactor, viewport.height / Starling.contentScaleFactor);
			starlingBG.copyPixels(backgroundDisplayObject.bitmapData, new Rectangle(viewport.x - backgroundDisplayObject.x / scale, viewport.y - backgroundDisplayObject.y / scale, starlingBG.width, starlingBG.height), new Point());
			var starlingBackgroundDisplayObject : Image = new Image(Texture.fromBitmapData(starlingBG));
			starlingBackgroundDisplayObject.blendMode = BlendMode.NONE;
			starlingBackgroundDisplayObject.touchable = false;
			YApplication.instance.starlingRoot.addChildAt(starlingBackgroundDisplayObject, 0);			
		}
	}
}
