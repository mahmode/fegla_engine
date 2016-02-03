package com.ahwagames
{
	import com.ahwagames.game.Game;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.net.SharedObject;
	
	public class Main extends Sprite
	{
		public static var instance:Main;
		
		public var currState:Sprite;
		public var so:SharedObject;
		
		public function Main():void
		{
			instance = this;
			so = SharedObject.getLocal("platformer", "/");
			Resource.init();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			setState(Menu);
		}
		
		public function setState(stateClass:Class):void
		{
			if (currState)
				removeChild(currState);
			
			currState = new stateClass();
			addChild(currState);
		}
	}
}