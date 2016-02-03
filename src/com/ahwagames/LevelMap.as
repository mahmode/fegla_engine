package com.ahwagames
{
	import com.ahwagames.game.Game;
	import com.ahwagames.game.Shop;
	import com.ahwagames.Main;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class LevelMap extends Sprite
	{
		private var main:Main;
		
		private var level:int = 1;
		private var currLvl:int = 1;
		
		public function LevelMap():void
		{
			main = Main.getInstance();
			
			btnStart.addEventListener(MouseEvent.CLICK, onStart);
			btnShop.addEventListener(MouseEvent.CLICK, onShop);
			btnMenu.addEventListener(MouseEvent.CLICK, onMenu);
			
			if (main.so.data.lvl)
				level = int(main.so.data.lvl);
			
			initButtos();
		}
		
		private function onMenu(e:MouseEvent):void
		{
			main.setActiveContent(Menu);
		}
		
		private function initButtos():void
		{
			for (var i:int = 1; i <= 10; i++)
			{
				if (i <= level)
				{
					this["n" + i].buttonMode = true;
					this["n" + i].gotoAndStop(2);
					this["n" + i].addEventListener(MouseEvent.MOUSE_OVER, onLevelOver);
					this["n" + i].addEventListener(MouseEvent.MOUSE_OUT, onLevelOut);
					this["n" + i].addEventListener(MouseEvent.CLICK, onLevelClick);
				}
			}
			
			setActiveLevel(level);
		}
		
		private function onLevelOver(e:MouseEvent):void
		{
			if (e.target.currentFrame == 2)
				e.target.gotoAndStop(3);
		}
		
		private function onLevelOut(e:MouseEvent):void
		{
			if (e.target.currentFrame == 3)
				e.target.gotoAndStop(2);
		}
		
		private function onLevelClick(e:MouseEvent):void
		{
			var id:int = int(e.target.name.substr(1));
			
			if (this["n" + id].currentFrame > 1) // not locked
				setActiveLevel(id);
		}
		
		public function setActiveLevel(lvl:int):void
		{
			for (var i:int = 1; i <= level; i++)
				this["n" + i].gotoAndStop(2);
			
			this["n" + lvl].gotoAndStop(4);
			currLvl = lvl;
		}
		
		private function onShop(e:MouseEvent):void
		{
			main.setActiveContent(Shop);
		}
		
		private function onStart(e:MouseEvent):void
		{
			main.setActiveContent(Game);
		}
	}
}