package y.util
{
	import ru.etcs.utils.getDefinitionNames;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import y.controls.YApplication;

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getTimer;

	[DefaultProperty("entries")]
	public class DynamicTextureAtlas
	{
		private const MAX_TEXTURE_WIDTH : int = 2048;
		public static var instance : DynamicTextureAtlas = new DynamicTextureAtlas();
		protected var _entries : Array = [];
		protected var textureAtlas : TextureAtlas;
		protected var texture : Texture;
		private var _addedEntries : Array = [];

		public function DynamicTextureAtlas(entries : Array = null)
		{
			if (entries != null)
				this._entries = entries;
		}
		
		public function setATFData(bytes : ByteArray, entries : Array) : void
		{
			for each (var dta : DTAEntry in entries) 
			{
				addDTA(dta);
			}
			Texture.fromAtfData(bytes);			
		}

		public static function insertAllEmbedds() : void
		{
			for each (var defName : String in (getDefinitionNames(YApplication.instance.loaderInfo, false, true)))
			{
				var classDef : Class = YApplication.instance.loaderInfo.applicationDomain.getDefinition(defName) as Class;
				var info : String = describeType(classDef) + "";
				if (info.indexOf("mx.core::BitmapAsset") >= 0 && YApplication.instance.theme.backgroundImage != classDef && info.indexOf("NTA") == -1)
				{
					instance.addEmbeddedImage(classDef);
				}
			}
		}

		public function getTexture(name : String) : Texture
		{
			if (textureAtlas == null)
				createAtlas();
			return textureAtlas.getTexture(name);
		}

		public function generateBitmapData(forceDimensionOfTwo : Boolean = false) : BitmapData
		{
			var x : int,y : int, maxX : int, maxY : int, i : int;
			_entries.sort(function(e1 : DTAEntry, e2 : DTAEntry) : int
			{
				return e2.bitmapData.height - e1.bitmapData.height;
			});
			for each (var entry : DTAEntry in _entries)
			{
				i++;
				if (x + entry.bitmapData.width + 1 > MAX_TEXTURE_WIDTH)
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

			// trace("[YMXML] sorting:" + (getTimer() - start) + "ms");
			if (forceDimensionOfTwo)
			{
				maxX = nextPowerOfTwo(maxX);
				maxY = nextPowerOfTwo(maxY);
			}

			var finalBitmap : BitmapData = new BitmapData(maxX, maxY, true, 0x00FFFFFF);
			var destination : Point = new Point();

			for each (entry in _entries)
			{
				destination.setTo(entry.atlasUsedRectangle.x, entry.atlasUsedRectangle.y);
				finalBitmap.copyPixels(entry.bitmapData, entry.bitmapData.rect, destination);
			}
			// trace("[YMXML] bitmap creation:" + (getTimer() - start) + "ms");
			return finalBitmap;
		}

		private function nextPowerOfTwo(maxX : Number) : int
		{
			var i : int = 0;
			while (maxX > 1)
			{
				maxX /= 2;
				i++;
			}
			return Math.pow(2, i);
		}

		public function addEmbeddedImage(image : Object) : String
		{
			if (image == null || image as Class == null)
				return "";
			var name : String = image + "";
			addDTA(new DTAEntry(image, name));
			return name;
		}

		public function addDTA(entry : DTAEntry) : void
		{
			if (_addedEntries[entry.name] != null)
				return;
			_addedEntries[entry.name] = true;
			_entries.push(entry);
			if (textureAtlas != null)
				textureAtlas = null;
		}

		public function set entries(content : Array) : void
		{
			_entries = _entries.concat(content);
		}

		[ArrayElementType("y.util.DTAEntry")]
		public function get entries() : Array
		{
			return _entries;
		}

		private function createAtlas() : void
		{
			var start : int = getTimer();

			var finalBitmap : BitmapData = generateBitmapData();

			// if(texture)
			// texture.dispose();
			texture = Texture.fromBitmapData(finalBitmap, false, false);
			textureAtlas = new TextureAtlas(texture);
			// trace("[YMXML] texture upload:" + (getTimer() - start) + "ms");

			// var rect : Rectangle = new Rectangle();
			for each (var entry : DTAEntry in _entries)
			{
				// rect.x = entry.atlasUsedRectangle.x * Starling.contentScaleFactor;
				// rect.y = entry.atlasUsedRectangle.y * Starling.contentScaleFactor;
				// rect.width = entry.atlasUsedRectangle.width * Starling.contentScaleFactor;
				// rect.height = entry.atlasUsedRectangle.height * Starling.contentScaleFactor;
				textureAtlas.addRegion(entry.name, entry.atlasUsedRectangle);
			}
			trace("[YMXML] Dynamic Texture Atlas:" + finalBitmap.width + "x" + finalBitmap.height + "px in " + (getTimer() - start) + "ms");
			finalBitmap.dispose();
		}
	}
}
