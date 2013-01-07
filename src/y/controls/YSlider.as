package y.controls
{
	import feathers.controls.Slider;
	
	[Event(name="change", type="flash.events.Event")]
	public class YSlider extends YSprite
	{
		override protected function createUIE() : void
		{
			uie = new Slider();						
		}
		
		public function get t():Slider { return uie as Slider; }
		
		public function get value():Number { return t.value; }
		public function set value(value:Number):void { t.value = value;}
		
		public function get maximum():Number { return t.maximum; }
		public function set maximum(value:Number):void { t.maximum = value;}
		
		public function get minimum():Number { return t.minimum; }
		public function set minimum(value:Number):void { t.minimum = value;}
		
		public function get step():Number { return t.step; }
		public function set step(value:Number):void { t.step = value;}
	}
}
