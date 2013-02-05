package y.controls
{
	import y.util.setTimeoutStarling;

	import starling.core.Starling;
	import starling.animation.Tween;

	import feathers.core.PopUpManager;

	public class YPopup extends YGroup
	{
		public static var fadeDuration : int = 500;
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
			}
			else
			{
				tween.fadeTo(0);
				setTimeoutStarling(tryRemovePopup, fadeDuration);
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
					trace(error.message);
				}
			}
		}
	}
}
