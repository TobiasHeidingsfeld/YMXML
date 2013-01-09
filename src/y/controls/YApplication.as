package y.controls
{
	import starling.core.Starling;

	import y.theme.YTheme;
	import y.util.EnvironmentHelper;

	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;

	[DefaultProperty("mxmlContent")]
	[Event(name="context3DCreate", type="flash.events.Event")]
	public class YApplication extends flash.display.Sprite
	{
		public static var instance : YApplication;
		public var starling : Starling;
		public var starlingRoot : FeathersRoot;
		public var theme : YTheme = new YTheme();
		private var fixedWidth : Number;
		private var fixedHeight : Number;
		private var _paddingTop : Number = 0;
		
		public function YApplication()
		{
			if (instance)
				throw new Error("YApplication is a singleton, can only be used once");
			instance = this;
			if (stage)
				initApplication(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, initApplication);
		}

		private function initApplication(event : Event) : void
		{
			fixedWidth = stage.stageWidth;
			fixedHeight = stage.stageHeight;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.LOW;
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			starling = new Starling(FeathersRoot, stage);
			starling.addEventListener("rootCreated", contextCreated);
			starling.start();
			starling.simulateMultitouch = true;			
		}

		private function contextCreated(event : Object) : void
		{
			setViewPort();
			
			if (theme)
				theme.apply();			
			
			for each (var item : YSprite in _content)
				starlingRoot.addChild(item.getUIE());

			dispatchEvent(new Event("context3DCreate"));

			addEventListener(Event.DEACTIVATE, handleActiveChange);
			addEventListener(Event.ACTIVATE, handleActiveChange);
			
			event;			
		}

		protected function setViewPort() : void
		{
			var scale : Number = Math.min(EnvironmentHelper.width / fixedWidth, (EnvironmentHelper.height - paddingTop) / fixedHeight);
			starling.viewPort = new Rectangle(0, paddingTop, fixedWidth * scale, fixedHeight * scale);			
		}

		private function handleActiveChange(event : Event) : void
		{
			var active : Boolean = event.type == Event.ACTIVATE;

			if (starling && active && !starling.isStarted)
				starling.start();
			if (starling && !active && starling.isStarted)
			{
				starling.nextFrame();
				starling.nextFrame();
				starling.stop();
			}
		}

		private var _content : Array = [];

		public function set mxmlContent(content : Array) : void
		{
			_content = content.concat(_content);
		}

		[ArrayElementType("y.controls.YSprite")]
		public function get mxmlContent() : Array
		{
			return _content;
		}

		public function set showStats(value : Boolean) : void
		{
			starling.showStats = value;
		}

		public function get paddingTop() : Number
		{
			return _paddingTop;
		}

		public function set paddingTop(paddingTop : Number) : void
		{
			this._paddingTop = paddingTop;
			setViewPort();
		}
	}
}
import starling.display.Sprite;
import flash.utils.setTimeout;
import y.controls.YApplication;

class FeathersRoot extends Sprite
{
	public function FeathersRoot()
	{
		YApplication.instance.starlingRoot = this;
		visible = false;
		setTimeout(show, 100);
	}

	private function show() : void
	{
		visible = true;
	}
}
