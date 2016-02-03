package com.fegla 
{
	import com.fegla.events.PlatformEvent;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.Event;
	
	/**
	 * The Hero is the human controlled character of the game
	 */
	public class Hero extends MultiStateFeglaItem
	{
		public var jumpPower:Number = 12;
		
		public var xSpeedMax:Number = 5;
		public var ySpeedMax:Number = 5;
		
		public var xSpeedPower:Number = 1;
		
		public var friction:Number = .7;
		
		public var fullHealth:Number = 100;
		public var health:Number = 100;
		
		public var onGround:Boolean;
		public var onLadder:Boolean = false;
		public var allowLadderSideMove:Boolean = false;
		public var allowLadderJump:Boolean = false;
		
		internal var currFriction:Number = 0;
		internal var thrust:Number = 0;
		internal var xSpeed:Number = 0;
		internal var ySpeed:Number = 0;
		internal var lastX:Number = 0;
		internal var lastY:Number = 0;
		
		public var controller:Controller;
		
		private var world:World;
		
		public function Hero(data:XML)
		{
			super(data);
			
			lastX = x;
			lastY = y;
			
			world = World.instance;
			
			drawDebugColor = 0x3399ff;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			controller = new Controller();
		}
		
		public override function setViewFromTextures(textures:Vector.<Texture>, fps:Number = 12):void
		{
			super.setViewFromTextures(textures, fps);
			
			view.pivotX = view.width / 2;
			view.pivotY = view.height;
		}
		
		public override function setViewFromTexture(texture:Texture):void
		{
			super.setViewFromTexture(texture);
			
			view.pivotX = view.width / 2;
			view.pivotY = view.height;
		}
		
		public function moveTo(xTo:Number, yTo:Number):void
		{
			x = xTo;
			y = yTo;
			lastX = x;
			lastY = y;
		}
		
		public override function drawDebug():void
		{
			super.drawDebug();
			
			viewDebug.pivotX = w / 2;
			viewDebug.pivotY = h;
		}
		
		public function update():void 
		{
			if (controller.isDown(controller.builtInControls.left) && (!onLadder || allowLadderSideMove))
			{
				if (currState != "walk")
					setState("walk");
				
				if (scaleX != -1)
					scaleX = -1;
				
				thrust = -xSpeedPower;
				xSpeed += thrust * world.viscosity;
				
				if (xSpeed < -xSpeedMax * world.viscosity)
					xSpeed = -xSpeedMax * world.viscosity;
			}
			else if (controller.isDown(controller.builtInControls.right) && (!onLadder || allowLadderSideMove))
			{
				if (currState != "walk") 
					setState("walk");
				
				if (scaleX != 1)
					scaleX = 1;
				
				thrust = xSpeedPower;
				xSpeed += thrust * world.viscosity;
				
				if (xSpeed > xSpeedMax * world.viscosity)
					xSpeed = xSpeedMax * world.viscosity;
			}
			else
			{
				if (currState != "stand")
					setState("stand");
				
				thrust = 0;
				
				if (onGround)
					xSpeed *= currFriction;
			}
			
			if (controller.isDown(controller.builtInControls.jump) && (onGround || (onLadder && allowLadderJump) || (world.currArea && world.currArea.allowJump && ySpeed > 0)))
			{
				var evt:PlatformEvent = new PlatformEvent(PlatformEvent.LEAVE_FLOOR);
				evt.platform = world.currPlatform;
				dispatchEvent(evt);
				
				ySpeed = -jumpPower;
				
				world.currPlatform = null;
				onGround = false;
				onLadder = false;
			}
		}
	}
}