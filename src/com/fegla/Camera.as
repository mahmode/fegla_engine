package com.fegla 
{
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import starling.display.DisplayObject;
	
	/**
	 * The world camera, the camera is responsible for viewing the level, it provides API to follow any level item most importantly the hero, plus moving the camera or zooming
	 */
	public class Camera 
	{
		/**
		 * In this camera mode, the camera will continuously follow the target
		 */
		public static const FOCUS_TARGET:String = "focus_target";
		
		/**
		 * In this camera mode, the camera will keep focusing on the current screen, but if the target leaves the screen, the camera will move to the new screen where the target exist
		 */
		public static const FOCUS_SCREEN:String = "focus_screen";
		
		/**
		 * the target of the camera, this is the item that the camera makes sure it is visible on the world view
		 */
		public var target:FeglaItem;
		
		/**
		 * the animation ease used when moving the camera. Camera can move using world.camera.moveTo() or when the camera mode is set to FOCUS_SCREEN and the screen is changed.
		 */
		public var ease:String = "Linear.easeNone";
		
		/**
		 * The amount of wait before the movement actually starts. Camera can move using world.camera.moveTo() or when the camera mode is set to FOCUS_SCREEN and the screen is changed.
		 */
		public var delay:Number = 0;
		
		/**
		 * the duration of the camera movement. Camera can move using world.camera.moveTo() or when the camera mode is set to FOCUS_SCREEN and the screen is changed.
		 */
		public var time:Number = 1;
		
		/**
		 * The mode the camera use to follow the target. It supports 2 modes. FOCUS_TARGET: the camera will continuously follow the target. FOCUS_SCREEN: the camera will keep focusing on the current screen, but if the target leaves the screen, the camera will move to the new screen where the target exist
		 */
		public var followMode:String = FOCUS_TARGET;
		
		private var screenRow:int = 0; // current values
		private var screenCol:int = 0;
		private var screenC:int; // calculated values
		private var screenR:int;
		
		private var world:World;
		
		/**
		 * Constructor
		 * 
		 * @param	world: The Fegla world
		 */
		public function Camera(world:World) 
		{
			this.world = world;
			
		}
		
		/**
		 * sets the target for the camera to look at
		 * 
		 * @param	tgt The camera target
		 */
		public function follow(tgt:FeglaItem):void 
		{
			target = tgt;
		}
		
		/**
		 * Moves the camera  to a new position
		 * 
		 * @param	xTo Target position x coordinate
		 * @param	yTo Target position y coordinate
		 * @param	time Time of the movement animation, if set to 0, the move is done with no animation.
		 * @param	delay The amount of wait before the movement actually starts
		 * @param	ease The animation ease used for the movement animation
		 */
		public function moveTo(xTo:Number, yTo:Number, time:Number = 0, delay:Number = 0, ease:String = null):void
		{
			if (time == 0) 
			{
				world.view.x = world.viewWidth / 2 - xTo;
				world.view.y = world.viewHeight / 2 - yTo;
				
				confineWorld();
			}
			else
			{
				var tweenObj:Object = {};
				tweenObj.x = world.viewWidth / 2 - xTo;
				tweenObj.y = world.viewHeight / 2 - yTo;
				tweenObj.delay = this.delay;
				tweenObj.ease = EaseLookup.find(this.ease);
				tweenObj.onUpdate = confineWorld;
				tweenObj.onStart = function ():void { world.hero.controller.enabled = false };
				tweenObj.onComplete = function ():void { world.hero.controller.enabled = true };
				
				if (delay > 0) tweenObj.delay = delay;
				if (ease != null) tweenObj.ease = EaseLookup.find(ease);
				
				TweenLite.to(world.view, time > 0 ? time : this.time, tweenObj );
			}
		}
		
		/** @private */
		internal function update():void
		{
			if (target)
			{
				if (followMode == FOCUS_TARGET)
				{
					world.view.x = world.viewWidth / 2 - world.hero.x;
					world.view.y = world.viewHeight / 2 - world.hero.y;
					
					confineWorld();
				}
				else // FOCUS_SCREEN
				{
					screenC = int(world.hero.x / world.viewWidth);
					screenR = int(world.hero.y / world.viewHeight);
					
					if (screenC != screenCol || screenR != screenRow)
					{
						screenCol = screenC;
						screenRow = screenR;
						
						moveTo((screenCol+.5) * world.viewWidth, (screenRow+.5) * world.viewHeight, time, delay, ease);
					}
				}
			}
		}
		
		private function confineWorld():void 
		{
			if (world.view.x > 0) world.view.x = 0;
			else if (world.view.x + world.levelWidth < world.viewWidth)
				world.view.x = world.viewWidth - world.levelWidth;
			
			if (world.view.y > 0) world.view.y = 0;
			else if (world.view.y + world.levelHeight < world.viewHeight)
				world.view.y = world.viewHeight - world.levelHeight;
		}
	}
}