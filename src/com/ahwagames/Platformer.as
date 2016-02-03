package com.ahwagames
{
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	import com.ahwagames.Main;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]
	public class Platformer extends Sprite
	{
		private var starling:Starling;
		
		public function Platformer():void
		{
			starling = new Starling(Main, stage);
			//starling.showStats = true;
			starling.start();
		}
	}
}