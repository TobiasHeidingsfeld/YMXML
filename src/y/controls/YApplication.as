package y.controls
{
	import y.util.DynamicTextureAtlas;

	import starling.core.Starling;

	import y.theme.YTheme;
	import y.util.EnvironmentHelper;

	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.geom.Rectangle;

	[DefaultProperty("mxmlContent")]
	[Event(name="context3DCreate", type="flash.events.Event")]
	[Event(name="starlingInitialized", type="flash.events.Event")]
	public class YApplication extends flash.display.Sprite
	{
		public static var instance : YApplication;
		public var starling : Starling;
		public var starlingRoot : FeathersRoot;
		public var theme : YTheme = new YTheme();
		public var starlingInitialized : Boolean;
		public var preCreatedTextureAtlas : Object;
		public var preCreatedTextureAtlasInfo : Object;
		private var fixedWidth : Number;
		private var fixedHeight : Number;
		private var _minPaddingTop : Number = 0;
		private var _showStats : Boolean;

		public function YApplication()
		{
			if (instance)
				trace("[YMXML]: YAPPLICATION SHOULD BE SINGLETON AND NOT CREATED MORE THEN ONCE");
			instance = this;
			if (stage)
				initApplication(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, initApplication);
		}

		protected function initApplication(event : Event) : void
		{
			fixedWidth = stage.stageWidth;
			fixedHeight = stage.stageHeight;
			stage.quality = StageQuality.LOW;
			Starling.handleLostContext = true;

			starling = new Starling(FeathersRoot, stage);
			starling.addEventListener("rootCreated", contextCreated);
			starling.start();
			starling.showStats = _showStats;

			starlingInitialized = true;
			dispatchEvent(new Event("starlingInitialized"));
		}

		private function contextCreated(event : Object) : void
		{
			setViewPort();

			if (theme)
				theme.apply();

			for each (var item : YDisplayObject in _content)
				starlingRoot.addChild(item.getUIE());

			dispatchEvent(new Event("context3DCreate"));

			event;
		}

		protected function setViewPort() : void
		{
			var scale : Number = Math.min(EnvironmentHelper.width / fixedWidth, (EnvironmentHelper.height - minPaddingTop) / fixedHeight);
			var offsetX : Number = (EnvironmentHelper.width - fixedWidth * scale) / 2;
			var offsetY : Number = ((EnvironmentHelper.height - minPaddingTop) - fixedHeight * scale) / 2 + minPaddingTop;
			if (scale > 0.1)
				starling.viewPort = new Rectangle(offsetX, offsetY, fixedWidth * scale, fixedHeight * scale);
		}

		private var _content : Array = [];

		public function set mxmlContent(content : Array) : void
		{
			_content = content.concat(_content);
		}

		[ArrayElementType("y.controls.YDisplayObject")]
		public function get mxmlContent() : Array
		{
			return _content;
		}

		public function set showStats(value : Boolean) : void
		{
			_showStats = value;
			if (starling)
				starling.showStats = value;
		}

		public function get minPaddingTop() : Number
		{
			return _minPaddingTop;
		}

		public function set minPaddingTop(paddingTop : Number) : void
		{
			this._minPaddingTop = paddingTop;
			try
			{
				setViewPort();
				theme.addBackground();
			}
			catch(error : Error)
			{
			}
		}

		public function insertAllEmbbededImages() : void
		{
			if (starlingInitialized)
				DynamicTextureAtlas.insertAllEmbedds();
			else
			{
				addEventListener("starlingInitialized", function(e : Object) : void
				{
					e;
					DynamicTextureAtlas.insertAllEmbedds();
				});
			}
		}
	}
}
import starling.display.Sprite;

import y.controls.YApplication;

import flash.utils.setTimeout;

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
