package com.fegla 
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * A felga item with multiple states. Like move, jump, stand...etc
	 */
	public class MultiStateFeglaItem extends FeglaItem
	{
		private var viewStates:Object;
		
		/**
		 * The current state of this fegla item
		 */
		public var currState:String;
		
		/**
		 * Constructor
		 * 
		 * @param	data	The xml data node for the instance
		 */
		public function MultiStateFeglaItem(data:XML) 
		{
			super(data);
			
			viewStates = {};
		}
		
		/**
		 * Set/switch the current state of this item
		 * 
		 * @param	stateId	the new state id
		 */
		public function setState(stateId:String):void
		{
			if (!viewStates[stateId]) 
				return;
			
			if (currState)
			{
				Starling.juggler.remove(view as MovieClip);
				removeChild(view);
			}
			
			currState = stateId;
			view = viewStates[stateId];
			Starling.juggler.add(view as MovieClip);
			addChild(view);
		}
		
		/**
		 * Add a textures vector for a new state
		 * 
		 * @param	textures	the textures vector
		 * @param	fps	frame rate for this state
		 * @param	stateId	id of newly added satte
		 * @param	facingRight	true of the textures are facing the right direction, false if left facing
		 */
		public function addStateTextures(textures:Vector.<Texture>, fps:Number, stateId:String, loop:Boolean = true, facingRight:Boolean = true):void
		{
            var mc:MovieClip = new MovieClip(textures, fps);
            mc.loop = loop;
			viewStates[stateId] = mc;
			
			if (!facingRight)
				mc.scaleX = -1;
			
			mc.pivotX = mc.width / 2;
			mc.pivotY = mc.height;
		}
		
		/** @private */
		protected override function onRemoved(e:Event):void
		{
			super.onRemoved(e);
			
			Starling.juggler.remove(view as MovieClip);
			removeChild(view);
			
			viewStates = null;
		}
	}
}