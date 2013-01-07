package y.controls
{
	import feathers.layout.HorizontalLayout;
	public class YHGroup extends YGroup
	{
		private var hLayout : HorizontalLayout = new HorizontalLayout();
		
		override protected function createUIE() : void
		{
			super.createUIE();
			t.layout = hLayout;
			hLayout.verticalAlign = "middle";
			hLayout.gap = 2;
		}
		
		public function get gap():Number { return hLayout.gap; }
		public function set gap(value:Number):void { hLayout.gap = value;}
		
		public function get verticalAlign():String { return hLayout.verticalAlign; }
		public function set verticalAlign(value:String):void { hLayout.verticalAlign = value;}
		
		public function get horizontalAlign():String { return hLayout.horizontalAlign; }
		public function set horizontalAlign(value:String):void { hLayout.horizontalAlign = value;}		
	}
}
