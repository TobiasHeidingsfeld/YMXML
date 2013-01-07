package y.controls
{
	import feathers.layout.VerticalLayout;

	public class YVGroup extends YGroup
	{
		private var vLayout : VerticalLayout = new VerticalLayout();
		
		override protected function createUIE() : void
		{
			super.createUIE();
			t.layout = vLayout;
			vLayout.horizontalAlign = "center";
			vLayout.gap = 2;
		}
		
		public function get gap():Number { return vLayout.gap; }
		public function set gap(value:Number):void { vLayout.gap = value;}
		
		public function get horizontalAlign():String { return vLayout.horizontalAlign; }
		public function set horizontalAlign(value:String):void { vLayout.horizontalAlign = value;}
		
		public function get verticalAlign():String { return vLayout.verticalAlign; }
		public function set verticalAlign(value:String):void { vLayout.verticalAlign = value;}
			
	}
}
