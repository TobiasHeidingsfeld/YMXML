package y.controls
{
	import feathers.controls.Label;
	import flash.filters.GlowFilter;
	import y.util.TextFormatHelper;

	public class YLabel extends YSprite
	{		
		override protected function createUIE() : void
		{
			uie = new Label();											
		}
		
		public function get t():Label { return uie as Label; }
		
		public function get text():String { return t.text; }
		public function set text(value:String):void { t.text = value;}
		
		public function get wordWrap():Boolean { return t.textRendererProperties["wordWrap"]; }
		public function set wordWrap(value:Boolean):void { t.textRendererProperties["wordWrap"] = value;}
		
		public function get filters():Array { return t.textRendererProperties["filters"]; }
		public function set filters(value:Array):void { t.textRendererProperties["filters"] = value;}

		public function set fontSize(value : Number) : void	{ TextFormatHelper.setFontSize(t.textRendererProperties, value);}
		
		public function set fontColor(value : Number) : void	{ TextFormatHelper.setFontColor(t.textRendererProperties, value);}
		
		public function set fontAlign(value : String) : void { TextFormatHelper.setFontAlign(t.textRendererProperties, value);}
		
		public function set outline(value : int) : void { filters = [new GlowFilter(value, 1, 6, 6, 10)];}
	}
}
