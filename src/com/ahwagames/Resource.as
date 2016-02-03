package com.ahwagames
{
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Resource
	{
		[Embed(source="../../../assets/btnPlay.png")]
		private static const btnPlay:Class;
		public static var btnPlayTexture:Texture;
		
		[Embed(source="../../../assets/bg.jpg")]
		private static const bg:Class;
		public static var bgTexture:Texture;
		
		[Embed(source="../../../assets/lvl1.xml", mimeType="application/octet-stream")]
		private static const lvl1XML:Class;
		public static var lvl1:XML;
		
		[Embed(source="../../../assets/atlas.png")]
		private static const atlas:Class;
		
		[Embed(source="../../../assets/atlas.xml", mimeType="application/octet-stream")]
		private static const atlasXML:Class;
		
		public static var ta:TextureAtlas;
		
		/*[Embed(source="assets/komika.png")]
		private static var komika:Class;
		
		[Embed(source="assets/komika.fnt", mimeType="application/octet-stream")]
		private static var komikaXML:Class;
		
		[Embed(source="assets/smoke.pex", mimeType="application/octet-stream")]
		public static var smokeXML:Class;
		
		[Embed(source="assets/explosion.mp3")]
		private static var explosionSound:Class;
		public static var explosion:Sound;*/
		
		public static function init():void
		{
			btnPlayTexture = Texture.fromBitmap(new btnPlay());
			
			bgTexture = Texture.fromBitmap(new bg());
			
			ta = new TextureAtlas(Texture.fromBitmap(new atlas()), XML(new atlasXML()));
			
			lvl1 = XML(new lvl1XML());
			
			//TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(new komika()), XML(new komikaXML())));
			
			//explosion = new explosionSound();
			//explosion.play(0, 0, new SoundTransform(0));
		}
	}
}