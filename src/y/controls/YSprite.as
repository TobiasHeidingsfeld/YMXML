package y.controls
{
	import starling.display.Sprite;

	[DefaultProperty("mxmlContent")]
	public class YSprite extends YDisplayObject
	{
		public function get sprite() : Sprite { return uie as Sprite; }
		
		protected var _content : Array;
		protected var overridePreviousMXMLContent : Boolean = true;
		
		override protected function createUIE() : void
		{
			uie = new Sprite();
		}

		public function set mxmlContent(content : Array) : void
		{
			if (overridePreviousMXMLContent && sprite.numChildren > 0)
				sprite.removeChildren();
			_content = content;
			for each (var item : YDisplayObject in _content)
				addChild(item);
		}

		[ArrayElementType("y.controls.YDisplayObject")]
		public function get mxmlContent() : Array
		{
			return _content;
		}

		public function addChild(item : YDisplayObject) : void
		{
			sprite.addChild(item.getUIE());
		}
		
		public function get flatten() : Boolean
		{
			return sprite.isFlattened;
		}

		public function set flatten(value : Boolean) : void
		{
			if (value) 
				sprite.flatten();
			else 
				sprite.unflatten();
		}

	}
}
