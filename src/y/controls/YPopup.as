package y.controls
{
	import y.util.setTimeoutYMXML;

	import starling.core.Starling;
	import starling.animation.Tween;

	import feathers.core.PopUpManager;

	public class YPopup extends YGroup
	{
		public static var defaultFadeDuration : int = 500;
		public var fadeDuration : int = defaultFadeDuration;
		public var modal : Boolean = true;

		override protected function createUIE() : void
		{
			super.createUIE();
			visible = false;
			alpha = 0;
		}

		private var _displayPopup : Boolean;

		public function get displayPopup() : Boolean
		{
			return _displayPopup;
		}

		public function set displayPopup(value : Boolean) : void
		{
			if (_displayPopup == value)
				return;
			_displayPopup = value;
			var tween : Tween = new Tween(uie, fadeDuration / 1000);
			if (_displayPopup)
			{
				visible = true;
				PopUpManager.addPopUp(uie, modal, true);
				tween.fadeTo(1);
				setTimeoutYMXML(PopUpManager.centerPopUp,  fadeDuration / 1000, uie);
			}
			else
			{
				tween.fadeTo(0);
				setTimeoutYMXML(tryRemovePopup, fadeDuration);
			}
			Starling.juggler.add(tween);
		}

		private function tryRemovePopup() : void
		{
			if (!_displayPopup)
			{
				try
				{
					PopUpManager.removePopUp(uie);
				}
				catch(error : Error)
				{
					
				}
			}
		}
	}
}
