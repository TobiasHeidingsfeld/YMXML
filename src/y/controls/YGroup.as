package y.controls
{
	import y.util.EnvironmentHelper;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.ILayout;

	public class YGroup extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new ScrollContainer();
			scrollable = false;
			clipContent = false;
			desktopScrollers = !EnvironmentHelper.isAir;															
		}

		public function get t() : ScrollContainer
		{
			return uie as ScrollContainer;			
		}
		
		public function get layout():ILayout { return t.layout; }
		public function set layout(value:ILayout):void { t.layout = value;}
		
		public function set scrollable(value:Boolean):void 
		{ 
			t.scrollerProperties["verticalScrollPolicy"] = t.scrollerProperties["horizontalScrollPolicy"] = value ? Scroller.SCROLL_POLICY_AUTO : Scroller.SCROLL_POLICY_OFF;
		}
		
		public function set clipContent(value:Boolean):void 
		{ 
			t.scrollerProperties["clipContent"] = value;
		}
		
		public function set desktopScrollers(value:Boolean):void 
		{ 
			t.scrollerProperties["scrollBarDisplayMode"] = value ? Scroller.SCROLL_BAR_DISPLAY_MODE_FIXED : Scroller.SCROLL_BAR_DISPLAY_MODE_FLOAT;
		}
	}
}
