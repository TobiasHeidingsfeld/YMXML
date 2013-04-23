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
	public class BackgroundContainerImage
	{
		private var backgroundDisplayObject : BitmapAsset;
		private var rectMask : Shape;
		private var starlingBackgroundDisplayObject : Image;
		private var texture : Texture;
		
		public function BackgroundContainerImage(backgroundImage : Object)
		{
			rectMask = new Shape();
			var viewport : Rectangle = Starling.current.viewPort;
			var scale : Number = Starling.contentScaleFactor;
			backgroundDisplayObject = new (backgroundImage)();
			backgroundDisplayObject.smoothing = true;
			backgroundDisplayObject.scaleX = backgroundDisplayObject.scaleY = scale;
			backgroundDisplayObject.x = (EnvironmentHelper.width - backgroundDisplayObject.width) / 2;
			backgroundDisplayObject.y = (EnvironmentHelper.height - backgroundDisplayObject.height + YApplication.instance.minPaddingTop) / 2;
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

			var bgX : Number = (viewport.x - backgroundDisplayObject.x) / scale;
			var bgY : Number = (viewport.y - backgroundDisplayObject.y) / scale;
			starlingBG.copyPixels(backgroundDisplayObject.bitmapData, new Rectangle(bgX, bgY, starlingBG.width, starlingBG.height), new Point());
			texture = Texture.fromBitmapData(starlingBG);
			starlingBackgroundDisplayObject = new Image(texture);
			starlingBackgroundDisplayObject.blendMode = BlendMode.NONE;
			starlingBackgroundDisplayObject.touchable = false;
			YApplication.instance.starlingRoot.addChildAt(starlingBackgroundDisplayObject, 0);			
		}

		public function dispose() : void
		{
			starlingBackgroundDisplayObject.removeFromParent(true);
			texture.dispose();
			backgroundDisplayObject.parent.removeChild(backgroundDisplayObject);
			rectMask.parent.removeChild(rectMask);
		}
	}
}
