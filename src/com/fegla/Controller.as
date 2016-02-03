package com.fegla 
{
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.events.KeyboardEvent;
	
	/**
	 * The controller is used to controls the hero movement and actions
	 */
	public class Controller 
	{
		/** @private */
		internal var builtInControls:Object = { left:0, right:0, up:0, down:0, jump:0 };
		
		private var _enabled:Boolean = true;
		private var keys:Array = [];
		
		/**
		 * Constructor
		 */
		public function Controller() 
		{
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKDown);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKUp);
			
			setMoveControls();
		}
		
		/**
		 * customize the default keyboard keys for controlling the hero
		 * 
		 * @param	left Left key
		 * @param	right Right key
		 * @param	up Up key
		 * @param	down Down key
		 * @param	jump Jump key
		 */
		public function setMoveControls(left:int = Keyboard.LEFT, right:int = Keyboard.RIGHT, up:int = Keyboard.UP, down:int = Keyboard.DOWN, jump:int = Keyboard.SPACE):void 
		{
			for (var s:String in builtInControls) 
				unregisterKey(builtInControls[s]);
			
			builtInControls.left = left;
			builtInControls.right = right;
			builtInControls.up = up;
			builtInControls.down = down;
			builtInControls.jump = jump;
			
			for (s in builtInControls) 
				registerKey(builtInControls[s]);
		}
		
		/**
		 * register a new key to be used via the controller
		 * 
		 * @param	keyCode The code of the key to be used
		 */
		public function registerKey(keyCode:int):void
		{
			keys[keyCode] = false;
		}
		
		/**
		 * unregister a key from the controller
		 * 
		 * @param	keyCode The code of the key to be unregistered
		 */
		public function unregisterKey(keyCode:int):void 
		{
			delete keys[keyCode];
		}
		
		/**
		 * checks whether of not the specified key is pressed
		 * 
		 * @param	keyCode The key code to be checked
		 * @return	true of the key is dwow, else false
		 */
		public function isDown(keyCode:int):Boolean
		{
			return keys[keyCode];
		}
		
		/**
		 * enable/disable the controller
		 */
		public function set enabled(yes:Boolean):void
		{
			_enabled = yes;
			
			if (!_enabled)
			{
				for (var s:String in keys)
					keys[s] = false;
			}
		}
		
		private function onKDown(e:KeyboardEvent):void
		{
			if (!_enabled) return;
			
			if (keys[e.keyCode] != null)
				keys[e.keyCode] = true;
		}
		
		private function onKUp(e:KeyboardEvent):void 
		{
			if (keys[e.keyCode] != null)
				keys[e.keyCode] = false;
		}
		
		/** @private */
		internal function destroy():void 
		{
			builtInControls = null;
			keys = null;
			
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKDown);
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onKUp);
		}
	}

}