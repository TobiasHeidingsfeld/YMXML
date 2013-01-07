package y.theme
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;


	[DefaultProperty("entries")]
	public class DynamicTextureAtlas
	{
		private const MAX_TEXTURE_WIDTH : int = 2048;
		public static var instance : DynamicTextureAtlas = new DynamicTextureAtlas();
		
		private var _entries : Array = [];
		private var textureAtlas : TextureAtlas;
		private var _addedEntries : Array = [];
		
		public function DynamicTextureAtlas(entries : Array = null)
		{
			if(entries != null)
				this._entries = entries;
		}

		public function getTexture(name : String) : Texture
		{
			if (textureAtlas == null)
				createAtlas();
			return textureAtlas.getTexture(name);
		}

		private function createAtlas() : void
		{
			var start : int = getTimer();
			var x : int,y : int, maxX : int, maxY : int, i : int;
			for each (var entry : DTAEntry in _entries)
			{
				i++;
				if (x + entry.bitmapData.width > MAX_TEXTURE_WIDTH)
				{
					x = 0;
					y = maxY + 1;
				}
				entry.atlasUsedRectangle = new Rectangle(x, y, entry.bitmapData.width, entry.bitmapData.height);
				x += entry.bitmapData.width + 1;
				if (x > maxX)
					maxX = x;
				if (y + entry.bitmapData.height > maxY)
					maxY = y + entry.bitmapData.height;				
			}
			
			//trace("[YMXML] sorting:" + (getTimer() - start) + "ms");
			
			var finalBitmap : BitmapData = new BitmapData(maxX, maxY, true, 0x00FFFFFF);
			var destination : Point = new Point();
			
			for each (entry in _entries)
			{
				destination.setTo(entry.atlasUsedRectangle.x, entry.atlasUsedRectangle.y);
				finalBitmap.copyPixels(entry.bitmapData, entry.bitmapData.rect, destination);
			}
			
			//trace("[YMXML] bitmap creation:" + (getTimer() - start) + "ms");
			
			textureAtlas = new TextureAtlas(Texture.fromBitmapData(finalBitmap));

			//trace("[YMXML] texture upload:" + (getTimer() - start) + "ms");
			
			for each (entry in _entries)
				textureAtlas.addRegion(entry.name, entry.atlasUsedRectangle);
			trace("[YMXML] Dynamic Texture Atlas:" + maxX + "x" + maxY + "px in " + (getTimer() - start) + "ms");
		}
		
		public function addEmbeddedImage(image : Object) : String
		{
			if(image == null)
				return "";
			var name : String = image + "";
			if(_addedEntries[name] != null)
				return name;			
			_addedEntries[name] = true;			
			addDTA(new DTAEntry(image, name));
			return name;	
		}
		
		public function addDTA(entry : DTAEntry) : void
		{
			_entries.push(entry);
			if(textureAtlas != null)
				textureAtlas = null;		
		}

		public function set entries(content : Array) : void
		{
			_entries = _entries.concat(content);
		}

		[ArrayElementType("y.theme.DTAEntry")]
		public function get entries() : Array
		{
			return _entries;
		}
	}
}
