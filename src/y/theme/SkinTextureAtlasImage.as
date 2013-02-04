package y.theme
{
	import starling.display.Image;
	import y.util.DynamicTextureAtlas;

	public class SkinTextureAtlasImage implements ISkinSetting
	{
		public var skinName : String;		
		public var textureName : String;

		public function initialize() : void
		{			
		}

		public function apply(item : Object) : void
		{			
			item[skinName] = new Image(DynamicTextureAtlas.instance.getTexture(textureName));			
		}
	}
}
