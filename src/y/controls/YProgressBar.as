package y.controls
{
	import feathers.controls.ProgressBar;

	public class YProgressBar extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new ProgressBar();
			t.value = 0;		
		}
		
		public function get t():ProgressBar { return uie as ProgressBar; }
		
		public function get value():Number { return t.value; }
		public function set value(value:Number):void { setProperty("value", value);}
		
		public function get maximum():Number { return t.maximum; }
		public function set maximum(value:Number):void { t.maximum = value;}
		
		public function get minimum():Number { return t.minimum; }
		public function set minimum(value:Number):void { t.minimum = value;}
		
		public function get vertical():Boolean { return t.direction == ProgressBar.DIRECTION_VERTICAL; }
		public function set vertical(value:Boolean):void { t.direction = value ? ProgressBar.DIRECTION_VERTICAL : ProgressBar.DIRECTION_HORIZONTAL;}
		
	}
}
