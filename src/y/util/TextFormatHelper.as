package y.util
{
	import flash.text.TextFormat;

	public class TextFormatHelper
	{
		private static const TEXT_FORMAT : String = 'textFormat';

		public static function setFontSize(textRendererProperties : Object, value : Number) : void
		{
			setFontProperty(textRendererProperties, "size", value);
		}

		public static function setFont(textRendererProperties : Object, value : String) : void
		{
			setFontProperty(textRendererProperties, "font", value);
		}

		public static function setFontColor(textRendererProperties : Object, value : int) : void
		{
			setFontProperty(textRendererProperties, "color", value);
		}

		public static function setFontAlign(textRendererProperties : Object, value : String) : void
		{
			setFontProperty(textRendererProperties, "align", value);
		}

		private static function setFontProperty(textRendererProperties : Object, property : String, value : Object) : void
		{
			var textFormat : TextFormat = clone(textRendererProperties[TEXT_FORMAT] as TextFormat);
			textFormat[property] = value;
			textRendererProperties[TEXT_FORMAT] = textFormat;
		}

		private static function clone(textFormat : TextFormat) : TextFormat
		{
			var clone : TextFormat = new TextFormat();
			if (textFormat != null)
			{
				clone.font = textFormat.font;
				clone.size = textFormat.size;
				clone.color = textFormat.color;
				clone.align = textFormat.align;
			}
			return clone;
		}
	}
}
class FormatChange
{
	public var textRendererProperties : Object;
	public var property : String;
	public var value : Object;

	public function FormatChange(textRendererProperties : Object, property : String, value : Object)
	{
		this.value = value;
		this.property = property;
		this.textRendererProperties = textRendererProperties;
	}
}
