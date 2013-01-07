package y.controls
{
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import y.theme.YTheme;
	import y.util.EnvironmentHelper;



	[DefaultProperty("mxmlContent")]
	[Event(name="Context3DCreated", type="flash.events.Event")]
	public class YApplication extends flash.display.Sprite
	{
		public static var instance : YApplication;
		public var starling : Starling;
		public var starlingRoot : FeathersRoot;
		public var fixedWidth : Number = 400;
		public var fixedHeight : Number = 400;
		public var paddingTop : Number = 0;
		public var theme : YTheme = new YTheme();
		
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
			starlingRoot = FeathersRoot.instance;
			
			var scale : Number = Math.min(EnvironmentHelper.width / fixedWidth, (EnvironmentHelper.height - paddingTop) / fixedHeight);
			starling.viewPort = new Rectangle(0, paddingTop, fixedWidth * scale, fixedHeight * scale);

			if (theme)
				theme.apply();			
			
			for each (var item : YSprite in _content)
				starlingRoot.addChild(item.getUIE());

			dispatchEvent(new Event("Context3DCreated"));

			addEventListener(Event.DEACTIVATE, handleActiveChange);
			addEventListener(Event.ACTIVATE, handleActiveChange);
			
			event;			
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
	}
}
import starling.display.Sprite;

import flash.utils.setTimeout;

class FeathersRoot extends Sprite
{
	public static var instance : FeathersRoot;

	public function FeathersRoot()
	{
		instance = this;
		visible = false;
		setTimeout(show, 100);
	}

	private function show() : void
	{
		visible = true;
	}
}
