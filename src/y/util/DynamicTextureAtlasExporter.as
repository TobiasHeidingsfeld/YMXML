package y.util
{
	import flash.events.ProgressEvent;

	import y.controls.YApplication;

	import mx.graphics.codec.PNGEncoder;

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class DynamicTextureAtlasExporter
	{
		public function DynamicTextureAtlasExporter()
		{
			if (EnvironmentHelper.isADL)
				YApplication.instance.addEventListener(Event.ADDED_TO_STAGE, addToStage);
			else
				loadATFTexture();
		}

		private function loadATFTexture() : void
		{
//			var file : File = new File("app:/Atlas.png");
//			file = new File(file.nativePath);
//			if (file.exists)
//			{
//				var stream : FileStream = new FileStream();
//				var bytes : ByteArray = new ByteArray();
//				stream.open(file, FileMode.READ);
//				stream.readBytes(bytes);
//				stream.close();
//				trace(bytes.length);
//				// DynamicTextureAtlas.instance.setATFData(bytes, entries)
//			}
		}

		private function addToStage(event : Event) : void
		{
			if (EnvironmentHelper.isADL)
				DynamicTextureAtlas.insertAllEmbedds();
			var encoder : PNGEncoder = new PNGEncoder();
			var bytes : ByteArray = encoder.encode(DynamicTextureAtlas.instance.generateBitmapData(true));
			writeFile("Atlas.png", bytes, null);
			writeFile("Atlas.txt", null, JSON.stringify(DynamicTextureAtlas.instance.entries));
			var file : File = new File("app:/Atlas");
			startATF("-c p -i " + file.nativePath + ".png -o " + file.nativePath + "iOS.atf");
			startATF("-c e -i " + file.nativePath + ".png -o " + file.nativePath + "Android.atf");
		}

		private function startATF(argsString : String) : void
		{
			var atfFile : File = new File("D:\\Tools\\Adobe Gaming SDK 1.0.1\\Utilities\\ATF Tools\\Windows\\png2atf.exe");
			if(!atfFile.exists)
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
