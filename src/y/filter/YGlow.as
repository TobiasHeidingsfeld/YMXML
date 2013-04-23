package y.filter
{
	import flash.events.Event;

	import y.controls.YApplication;

	import starling.filters.FragmentFilter;
	import starling.filters.BlurFilter;

	public class YGlow implements IYFilter
	{
		private var blurFilter : BlurFilter;

		public function YGlow(color : uint = 16711680, alpha : Number = 1.0, blur : Number = 1.0, resolution : Number = 0.5)
		{
			if (YApplication.instance.starling && YApplication.instance.starling.context)
				blurFilter = BlurFilter.createGlow(color, alpha, blur, resolution);
			else
				YApplication.instance.addEventListener(Event.CONTEXT3D_CREATE, function(e : *) : void
				{
					e;
					blurFilter = BlurFilter.createGlow(color, alpha, blur, resolution);	
				});
		}

		public function get filter() : FragmentFilter
		{
			return blurFilter;
		}
	}
}
