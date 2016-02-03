package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	import com.ahwagames.Main;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#ffffff")]
	public class Platformer extends Sprite
	{
		private var starling:Starling;
		
		public function Platformer():void
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			starling = new Starling(Main, stage);
			starling.start();
		}
	}
}