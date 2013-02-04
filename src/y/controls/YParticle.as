package y.controls
{
	import flash.events.Event;
	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;
	import y.util.DynamicTextureAtlas;



	public class YParticle extends YSprite
	{		
		private var _particleSystem : PDParticleSystem;
		private var _config : Object;
		private var _textureAtlasName : String;
		private var _running : Boolean;
		
		public function YParticle()
		{
			//standart config und particle texture setzen ?!
			//particle amount begrenzen?
		}

		public function start(duration : Number = Number.MAX_VALUE) : void
		{
			_particleSystem.start(duration / 1000);
		}

		private function updateParticleSystem() : void
		{
			if (_particleSystem)
			{
				uie.removeChild(_particleSystem);
				Starling.juggler.remove(_particleSystem);
			}
			if (_textureAtlasName && _config)
			{
				if (Starling.current && Starling.current.context)
				{
					_particleSystem = new PDParticleSystem(XML(new (_config)()), DynamicTextureAtlas.instance.getTexture(_textureAtlasName));
					running = _running;
					uie.addChild(_particleSystem);
					Starling.juggler.add(_particleSystem);
					start();
				}
				else
					YApplication.instance.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated);
			}
		}

		private function handleContextCreated(event : *) : void
		{
			YApplication.instance.removeEventListener(event["type"], handleContextCreated);
			updateParticleSystem();
		}

		public function set texture(texture : Object) : void
		{
			_textureAtlasName = DynamicTextureAtlas.instance.addEmbeddedImage(texture);
			updateParticleSystem();
		}

		public function set config(config : Object) : void
		{
			_config = config;
			updateParticleSystem();
		}

		public function set running(running : Boolean) : void
		{
			if(_particleSystem && running)
				_particleSystem.start();
			if(_particleSystem && !running)
				_particleSystem.stop();
			_running = running;
		}

		public function get system() : PDParticleSystem
		{
			return _particleSystem;
		}
	}
}
