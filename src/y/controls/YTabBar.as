package y.controls
{
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;

	public class YTabBar extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new TabBar();
		}
		
		public function get t():TabBar { return uie as TabBar; }
		
		public function get selectedIndex():int { return t.selectedIndex; }
		public function set selectedIndex(value:int):void { t.selectedIndex = value;}
		
		public function get items():Array { return t.dataProvider.data as Array; }
		public function set items(value:Array):void { t.dataProvider = new ListCollection(value);}
	}
}
