package y.theme
{
	import flash.text.TextFormat;

	public class SkinTextFormat implements ISkinSetting
	{
		public var textPropertiesName : String;
		public var font : String = "defaultFont";
		public var size : int = 20;
		public var color : int = 0;
		private var _textFormat : TextFormat;
		
		public function initialize() : void
		{
			_textFormat = new TextFormat(font, size, color);
		}

		public function apply(item : Object) : void
		{
			var existingFormat : TextFormat = item[textPropertiesName]["textFormat"] as TextFormat;
			if(existingFormat != null)
			{
				if(existingFormat.font == null)
					existingFormat.font = _textFormat.font;
				if(existingFormat.size == null)
					existingFormat.size = _textFormat.size;
				if(existingFormat.color == null)
					existingFormat.color = _textFormat.color;
				if(existingFormat.align == null)
					existingFormat.align = _textFormat.align;
				item[textPropertiesName]["textFormat"] = existingFormat;
			}
			else
				item[textPropertiesName]["textFormat"] = _textFormat;
		}
	}
}
