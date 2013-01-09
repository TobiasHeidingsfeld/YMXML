package y.controls
{
	import feathers.core.PopUpManager;

	public class YPopup extends YGroup
	{
		public var modal : Boolean = true;
		
		override protected function createUIE() : void
		{
			super.createUIE();			
			visible = false;
		}
		
		private var _displayPopup : Boolean;
				
		public function get displayPopup() : Boolean
		{
			return _displayPopup;
		}

		public function set displayPopup(value : Boolean) : void		
		{
			if(_displayPopup == value)
				return;
			_displayPopup = value;
			if(_displayPopup)
			{
				visible = true;
				PopUpManager.addPopUp(getUIE(), modal, true);								
			}
			else
			{
				PopUpManager.removePopUp(getUIE());
			}
		}

	}
}
