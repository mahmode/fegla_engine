package com.ahwagames.game
{
	import com.ahwagames.LevelMap;
	import com.ahwagames.Main;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Shop extends Sprite
	{
		private var main:Main;
		
		public function Shop()
		{
			main = Main.getInstance();
			
			btnBack.addEventListener(MouseEvent.CLICK, onBack);
		}
		
		private function onBack(e:Event):void 
		{
			main.setActiveContent(LevelMap);
		}
	}
}