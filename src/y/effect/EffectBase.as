package y.effect
{
	import starling.animation.Tween;
	import starling.core.Starling;

	import flash.events.EventDispatcher;
	
	public class EffectBase extends EventDispatcher
	{
		public var removeOldTween : Boolean = true;
		public var duration : int = 500;
		public var delay : int = 0;
		public var reverse : Boolean;
		public var repeatCount : int = 1;
		public var transition : String = Transitions.LINEAR;
		protected var tween : Tween;
		protected var _autoPlay : Boolean;
		
		private var _target : Object = null;		
		
		public function play() : void
		{
			if(target == null)
				return;
			if(tween && !tween.isComplete && removeOldTween)
				Starling.juggler.remove(tween);
			tween = new Tween(target, duration / 1000, transition);
			tween.reverse = reverse;
			tween.repeatCount = repeatCount;
			tween.delay = delay / 1000;
			addTweens();
			Starling.juggler.add(tween);			
		}
		
		protected function addTweens(): void
		{
			
		}

		public function get autoPlay() : Boolean
		{
			return _autoPlay;
		}

		public function set autoPlay(autoPlay : Boolean) : void
		{
			this._autoPlay = autoPlay;
			checkAutoPlay();			
		}

		protected function checkAutoPlay() : void
		{
			if(autoPlay && target)
				play();
		}

		public function get target() : Object
		{
			return _target;
		}

		public function set target(target : Object) : void
		{
			this._target = target;
			checkAutoPlay();
		}
	}
}
