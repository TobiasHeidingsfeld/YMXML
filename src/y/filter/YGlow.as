package y.filter
{
	import starling.filters.FragmentFilter;
	import starling.filters.BlurFilter;

	public class YGlow implements IYFilter
	{
		private var blurFilter : BlurFilter;
		
		public function YGlow(color : uint = 0xffff00, alpha : Number = 1.0, blur : Number = 1.0, resolution : Number = 0.5)
		{
			blurFilter = BlurFilter.createGlow(color, alpha, blur, resolution);
		}

		public function get filter() : FragmentFilter
		{
			return blurFilter;
		}
	}
}
