package y.controls
{
	import y.effect.EffectBase;
	import y.util.setTimeoutYMXML;

	import mx.collections.IList;
	import mx.core.IFactory;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;

	public class YDatagroup extends YGroup
	{
		public var removeEffect : EffectBase;
		public var objectPoolingEnabled : Boolean = true;
		private var _objectPoolItemRenderers : Array = [];

		override protected function createUIE() : void
		{
			super.createUIE();
		}

		private var _dataProvider : IList;
		private var _instantiadedItemRenderers : Array;

		public function get dataProvider() : IList
		{
			return _dataProvider;
		}

		public function set dataProvider(value : IList) : void
		{
			if (_dataProvider)
				_dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, handleCollectionChange);
			_dataProvider = value;
			if (_dataProvider)
				_dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, handleCollectionChange);
			createRenderers();
		}

		private function handleCollectionChange(event : CollectionEvent) : void
		{
			if (_itemRenderer == null)
				return;
			var renderer : YItemRenderer;
			var i : int;
			if (event.kind == CollectionEventKind.ADD)
			{
				for each (var data : Object in event.items)
				{
					renderer = createRenderer();
					_instantiadedItemRenderers.push(renderer);
					t.addChild(renderer.getUIE());
					renderer.data = data;
				}
			}
			if (event.kind == CollectionEventKind.REPLACE)
			{
				for (i = 0; i < event.items.length; i++)
				{
					renderer = _instantiadedItemRenderers[event.location + i];
					renderer.data = event.items[i];
				}
			}
			if (event.kind == CollectionEventKind.RESET)
				remove(sprite.numChildren, 0);
			if (event.kind == CollectionEventKind.REMOVE)
				remove(event.items.length, event.location);			
		}

		private function remove(length : uint, location : int) : void
		{
			for (var i : int = 0; i < length; i++)
			{
				var renderer : YItemRenderer = _instantiadedItemRenderers[location + i];
				var removeTime : int = 0;
				if (removeEffect)
				{
					removeEffect.removeOldTween = false;
					removeEffect.target = renderer.getUIE();
					removeEffect.play();
					removeTime = removeEffect.delay + removeEffect.duration;
				}
				if(removeTime > 0)
					setTimeoutYMXML(removeRenderer, removeTime, renderer);
				else
					removeRenderer(renderer);
			}
			_instantiadedItemRenderers.splice(location, length);
		}

		private function createRenderer() : YItemRenderer
		{
			if (_objectPoolItemRenderers.length > 0)
				return _objectPoolItemRenderers.pop();
			return  _itemRenderer.newInstance();
		}

		private function createRenderers() : void
		{
			if (_itemRenderer == null)
				return;
			for each (var removedItem : YItemRenderer in _instantiadedItemRenderers)
				removeRenderer(removedItem);
			_instantiadedItemRenderers = [];
			if (_dataProvider)
			{
				for (var i : int = 0; i < _dataProvider.length; i++)
				{
					var renderer : YItemRenderer = createRenderer();
					_instantiadedItemRenderers.push(renderer);
					t.addChild(renderer.getUIE());
					var data : Object = _dataProvider.getItemAt(i);
					if (renderer.data != data)
						renderer.data = data;
				}
			}
		}

		private function removeRenderer(renderer : YItemRenderer) : void
		{
			t.removeChild(renderer.getUIE());
			if (objectPoolingEnabled)
				_objectPoolItemRenderers.push(renderer);
		}

		private var _itemRenderer : IFactory;

		public function get itemRenderer() : IFactory
		{
			return _itemRenderer;
		}

		public function set itemRenderer(value : IFactory) : void
		{
			_itemRenderer = value;
			createRenderers();
		}
	}
}
