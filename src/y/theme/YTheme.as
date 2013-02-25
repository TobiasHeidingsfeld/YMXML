package y.theme
{
	import feathers.controls.text.StageTextTextEditor;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.ITextEditor;
	import feathers.core.ITextRenderer;
	import feathers.core.PopUpManager;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;

	import y.controls.YApplication;

	[DefaultProperty("skins")]
	public class YTheme
	{
		public var defaultFont : Object;
		public var backgroundImage : Object;
		public var chromeColor : int = 0xCCAACC;
		public var scale : Number = 1;
		private var displayWatcher : DisplayListWatcher;
		private var bgContainer : BackgroundContainerImage;

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
			if(bgContainer)
				bgContainer.dispose();
			bgContainer = new BackgroundContainerImage(backgroundImage);
		}

		public function apply() : void
		{
			displayWatcher = new DisplayListWatcher(YApplication.instance.starling.root as DisplayObjectContainer);
			for each (var skin : SkinSettings in _skins)
				skin.apply(displayWatcher);
			addBackground();			
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
			quad.alpha = 0.6;
			return quad;
		}

		protected function textEditorFactory() : ITextEditor
		{
			var stageTextEditor : StageTextTextEditor = new StageTextTextEditor();
			stageTextEditor.fontFamily = "_serif";
			stageTextEditor.fontSize = 20;
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
