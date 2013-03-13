package y.util
{
	import y.controls.YApplication;

	import mx.graphics.codec.PNGEncoder;

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public class DynamicTextureAtlasExporter
	{
		public function DynamicTextureAtlasExporter()
		{
			if (EnvironmentHelper.isADL)
				YApplication.instance.addEventListener(Event.ADDED_TO_STAGE, addToStage);
		}

		public function set AtlasData(atlas : Object) : void
		{
			if (EnvironmentHelper.isADL)
				return;
			YApplication.instance.stopCreation = true;
			var byteArray : ByteArray = new atlas();
			if(byteArray.bytesAvailable < 4)
				return;
			var length : int = byteArray.readInt();
			while (byteArray.position < length)
			{
				var dta : DTAEntry = new DTAEntry();
				dta.atlasUsedRectangle = new Rectangle(byteArray.readInt(), byteArray.readInt(), byteArray.readInt(), byteArray.readInt());
				dta.name = byteArray.readUTF();
				DynamicTextureAtlas.instance.addDTA(dta);
			}
			var bitmapData : BitmapData = new BitmapData(byteArray.readInt(), byteArray.readInt(), true, 0x00FF0000);
			var imageBytes : ByteArray = new ByteArray();
			byteArray.readBytes(imageBytes);
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, function(e : Event) : void
			{
				bitmapData.draw(loader);
				YApplication.instance.stopCreation = false;
				YApplication.instance.contextCreated(null);				
			});
			loader.loadBytes(imageBytes);
			DynamicTextureAtlas.instance.preCreatedBitmapData = bitmapData;			
		}

		private function addToStage(event : Event) : void
		{
			YMXMLHelper.prepareImages();
			var encoder : PNGEncoder = new PNGEncoder();			
			var bitmapData : BitmapData = DynamicTextureAtlas.instance.generateBitmapData(true);
			var imageBytes : ByteArray = encoder.encode(bitmapData);
			var metaDataBytes : ByteArray = new ByteArray();
			for each (var dta : DTAEntry in DynamicTextureAtlas.instance.entries)
			{
				metaDataBytes.writeInt(dta.atlasUsedRectangle.x);
				metaDataBytes.writeInt(dta.atlasUsedRectangle.y);
				metaDataBytes.writeInt(dta.atlasUsedRectangle.width);
				metaDataBytes.writeInt(dta.atlasUsedRectangle.height);
				metaDataBytes.writeUTF(dta.name);
			}
			writeFile("Atlas.png", imageBytes, null);
			writeFile("Atlas.txt", metaDataBytes, null);
			var combinedBytes : ByteArray = new ByteArray();
			combinedBytes.writeInt(metaDataBytes.length);
			combinedBytes.writeBytes(metaDataBytes);
			combinedBytes.writeInt(bitmapData.width);
			combinedBytes.writeInt(bitmapData.height);
			combinedBytes.writeBytes(imageBytes);
			writeFile("CA.txt", combinedBytes, null);
			var file : File = new File("app:/Atlas");
			startATF("-c p -i " + file.nativePath + ".png -o " + file.nativePath + "iOS.atf");
			startATF("-c e -i " + file.nativePath + ".png -o " + file.nativePath + "Android.atf");
		}

		private function startATF(argsString : String) : void
		{
			var atfFile : File = new File("D:\\Tools\\Adobe Gaming SDK 1.0.1\\Utilities\\ATF Tools\\Windows\\png2atf.exe");
			if (!atfFile.exists)
			{
				trace("ATF NOT FOUND");
				return;
			}
			var nativeProcessStartupInfo : NativeProcessStartupInfo = new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable = atfFile;

			var args : Vector.<String> = new Vector.<String>();
			for each (var arg : String in argsString.split(" "))
			{
				args.push(arg);
			}
			nativeProcessStartupInfo.arguments = args;
			var process : NativeProcess = new NativeProcess();
			process.start(nativeProcessStartupInfo);
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, handleOutput);
			process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, errorDataHandler);
		}

		private function errorDataHandler(event : ProgressEvent) : void
		{
			var process : NativeProcess = event.target as NativeProcess;
			trace(process.standardError.readUTFBytes(process.standardError.bytesAvailable));
		}

		private function handleOutput(event : ProgressEvent) : void
		{
			var process : NativeProcess = event.target as NativeProcess;
			trace(process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable));
		}

		private function writeFile(name : String, bytes : ByteArray, string : String) : void
		{
			var file : File = new File("app:/" + name);
			file = new File(file.nativePath);
			var stream : FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			if (bytes)
				stream.writeBytes(bytes);
			else
				stream.writeUTFBytes(string);
			stream.close();
		}
	}
}
