package y.controls
{
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.ILayout;

	public class YGroup extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new ScrollContainer();
			scrollable = false;															
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
	}
}
