package y.util
{
	import starling.core.Starling;
	public function setTimeoutYMXML(closure : Function, delay : Number, ...args : *) : void
	{
		Starling.juggler.delayCall.apply(null, [closure, delay / 1000].concat(args));
	}
}
