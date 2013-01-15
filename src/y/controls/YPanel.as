package y.controls
{
	import feathers.layout.VerticalLayout;

	import y.display.PanelDisplay;

	public class YPanel extends YGroup
	{
		public var titleLabel : YLabel = new YLabel();
		protected var vLayout : VerticalLayout = new VerticalLayout();
				
		override protected function createUIE() : void
		{
			uie = new PanelDisplay();
			overridePreviousMXMLContent = false;
			addChild(titleLabel);
			t.layout = vLayout;
			vLayout.horizontalAlign = "center";
			vLayout.gap = 2;		
			vLayout.paddingTop = 10;
			vLayout.paddingLeft = 10;
			vLayout.paddingRight = 10;
			vLayout.paddingBottom = 10;			
		}
		
		public function get title():String { return titleLabel.text; }
		public function set title(value:String):void { titleLabel.text = value;}	
	}
}
