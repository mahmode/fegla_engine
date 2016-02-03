package com.ahwagames
{
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.textures.Texture;
	import starling.events.Event;
	import com.ahwagames.game.Game;
	
	public class Menu extends Sprite
	{
		private var main:Main;
		
		public function Menu():void
		{
			main = Main.instance;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			createUI();
		}
		
		private function createUI():void 
		{
			var btnStart:Button = new Button(Resource.btnPlayTexture);
			btnStart.pivotX = btnStart.width * .5;
			btnStart.pivotY = btnStart.height * .5;
			btnStart.x = stage.stageWidth / 2;
			btnStart.y = stage.stageHeight / 2;
			btnStart.addEventListener(Event.TRIGGERED, onStart);
			addChild(btnStart);
			
			//btnHow.addEventListener(Event.TRIGGERED, onHow);
		}
		
		private function onStart(e:Event):void
		{
			main.setState(Game);
		}
		
		private function onHow(e:Event):void
		{
			trace("onHow");
		}
		
		private function onRemoved(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
		}
	}
}