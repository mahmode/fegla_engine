package com.fegla 
{
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import starling.events.Event;
	
	/**
	 * A platform is the item that the hero/enemies can walk on, platform can be either OneWay: detects hero/enemies from above only hence can be jumped on from below or Block: a block is a solid rectangle that the hero/enemies cannot pass through from either of the 5 directions.
	 */
	public class Platform extends FeglaItem
	{
		public static const OneWay:int = 1;
		public static const Block:int = 2;
		
		public var type:int = OneWay;
		public var moving:Boolean = false;
		public var active:Boolean = true;
		public var forceX:Number = 0;
		public var forceY:Number = 0;
		public var friction:Number = .5;
		
		internal var lastX:Number;
		internal var lastY:Number;
		
		public function Platform(data:XML)
		{
			super(data);
			
			init();
			
			drawDebugColor = type == OneWay ? 0xffffff : 0xcc0000;
		}
		
		private function init():void 
		{
			// set playform type onway/block
			if (data.@type.toString() == "block")
			{
				type = Block;
			}
			else
			{
				type = OneWay;
				rotation = Number(data.@r) * Math.PI / 180;
			}
			
			if (Number(data.@f) > 0)
				friction = Number(data.@f);
			
			if (Number(data.@fx) != 0)
				forceX = Number(data.@fx);
			
			if (Number(data.@fy) != 0)
				forceY = Number(data.@fy);
			
			if (data.@a.length() > 0 && Number(data.@a) == 0)
				active = false;
			
			// check moving platform
			var moveTime:Number = Number(data.@moveTime);
			
			if (moveTime > 0) // moving platform
			{
				moving = true;
				
				var moveX:Number = Number(data.@moveX);
				var moveY:Number = Number(data.@moveY);
				var moveEase:String = data.@moveEase.toString();
				var moveDelay:Number = Number(data.@moveDelay);
				var tweenObj:Object = { repeat: -1, yoyo:true, ease:Linear.easeNone };
				
				if (moveX > 0) tweenObj.x = moveX;
				if (moveY > 0) tweenObj.y = moveY;
				if (moveDelay > 0) tweenObj.repeatDelay = moveDelay;
				if (moveEase) tweenObj.ease = EaseLookup.find(moveEase);
				
				TweenMax.to(this, moveTime, tweenObj);
			}
		}
		
		/**
		 * Moves the platform to a new position
		 * 
		 * @param	xTo Target position x coordinate
		 * @param	yTo Target position y coordinate
		 * @param	time Time of the movement animation, if set to 0, the move is done with no animation.
		 * @param	delay The amount of wait before the movement actually starts
		 * @param	ease The animation ease used for the movement animation
		 */
		public function moveTo(xTo:Number, yTo:Number, time:Number = 0, delay:Number = 0, ease:String = "Linear.easeNone"):void
		{
			if (time == 0) 
			{
				x = xTo;
				y = yTo;
			}
			else
			{
				var tweenObj:Object = {};
				tweenObj.x = xTo;
				tweenObj.y = yTo;
				tweenObj.delay = delay;
				tweenObj.ease = EaseLookup.find(ease);
				tweenObj.onStart = function ():void { moving = true; };
				tweenObj.onComplete = function ():void { moving = false; };
				
				TweenLite.to(this, time, tweenObj );
			}
		}
		
		/** @private */
		override protected function onRemoved(e:Event):void 
		{
			super.onRemoved(e);
			
			TweenMax.killTweensOf(this);
		}
	}
}