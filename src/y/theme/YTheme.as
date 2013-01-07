package y.theme
{
	import feathers.controls.text.StageTextTextEditor;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.ITextEditor;
	import feathers.core.ITextRenderer;
	import feathers.core.PopUpManager;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import mx.core.BitmapAsset;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	import y.controls.YApplication;
	import y.util.EnvironmentHelper;

	[DefaultProperty("skins")]
	public class YTheme
	{
		public var defaultFont : Object;
		public var backgroundImage : Object;
		public var chromeColor : int = 0xCCAACC;
		public var scale : Number = 1;
		private var displayWatcher : DisplayListWatcher;

		public function YTheme()
		{
			FeathersControl.defaultTextRendererFactory = textRendererFactory;
			FeathersControl.defaultTextEditorFactory = textEditorFactory;
			PopUpManager.overlayFactory = popUpOverlayFactory;
		}

		public function addBackground() : void
		{
			if (backgroundImage == null)
				return;
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

		public function apply() : void
		{
			addBackground();
			displayWatcher = new DisplayListWatcher(YApplication.instance.starling.root as DisplayObjectContainer);
			for each (var skin : SkinSettings in _skins)
				skin.apply(displayWatcher);
		}

		protected function textRendererFactory() : ITextRenderer
		{
			var textFieldTextRenderer : YTextFieldRenderer = new YTextFieldRenderer();
			if (defaultFont != null)
				textFieldTextRenderer.embedFonts = true;
			return textFieldTextRenderer;
		}

		protected function popUpOverlayFactory() : DisplayObject
		{
			const quad : Quad = new Quad(100, 100, 0x1a1a1a);
			quad.alpha = 0.85;
			return quad;
		}

		protected function textEditorFactory() : ITextEditor
		{
			var stageTextEditor : StageTextTextEditor = new StageTextTextEditor();
			stageTextEditor.fontFamily = "_serif";
			stageTextEditor.fontSize = 20 * Starling.contentScaleFactor;
			return stageTextEditor;
		}

		private var _skins : Array = [];

		public function set skins(content : Array) : void
		{
			_skins = _skins.concat(content);
		}

		[ArrayElementType("y.theme.SkinSettings")]
		public function get skins() : Array
		{
			return _skins;
		}
	}
}
