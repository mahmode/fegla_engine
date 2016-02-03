package com.ahwagames.game 
{
	import com.ahwagames.Main;
	import com.ahwagames.Menu;
	import com.ahwagames.Resource;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ConfirmLeave extends Sprite 
	{
		private var main:Main;
		private var game:Game;
		
		public function ConfirmLeave()
		{
			main = Main.instance;
			game = main.currState as Game;
			
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
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x663300);
			bg.alpha = .1;
			addChild(bg);
			
			var btnLeave:Button = new Button(Resource.btnPlayTexture);
			btnLeave.x = stage.stageWidth * .5 - btnLeave.width * .5;
			btnLeave.y = stage.stageHeight * .5 - btnLeave.height - 5;
			btnLeave.addEventListener(Event.TRIGGERED, onLeave);
			addChild(btnLeave);
			
			var btnCancel:Button = new Button(Resource.btnPlayTexture);
			btnCancel.x = stage.stageWidth * .5 - btnLeave.width * .5;
			btnCancel.y = stage.stageHeight * .5 + 5;
			btnCancel.addEventListener(Event.TRIGGERED, onCancel);
			addChild(btnCancel);
		}
		
		private function onLeave(e:Event):void
		{
			main.setState(Menu); // LevelMap
		}
		
		private function onCancel(e:Event):void
		{
			game.removeCurrPanel();
		}
		
		private function onRemoved(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
		}
	}
}