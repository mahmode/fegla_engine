package com.fegla 
{
	import com.fegla.texture.TextureFillMode;
	import com.fegla.texture.TextureTile;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * FeglaItem is the root parent for any object in the fegla world
	 */
	public class FeglaItem extends Sprite
	{
		/**
		 * The visual view of the item
		 */
		public var view:DisplayObject;
		
		/**
		 * The debug visual view of the item
		 * 
		 * @private
		 */
		protected var viewDebug:Quad;
		
		/**
		 * Unqie id of the item
		 */
		public var id:int;
		
		/**
		 * Width of the item, as defined in the fegla editor
		 */
		public var w:Number = 0;
		
		/**
		 * Height of the item, as defined in the fegla editor
		 */
		public var h:Number = 0;
		
		/**
		 * The color used to draw this item for debug
		 */
		protected var drawDebugColor:int = 0xffffff;
		
		/**
		 * The xml data node for this item, it contains the item id, x, y, w...etc
		 */
		protected var data:XML;
		
		/**
		 * Constructor
		 * 
		 * @param	data	The xml data node for the instance
		 */
		public function FeglaItem(data:XML)
		{
			this.data = data;
			
			id = Number(data.@id);
			x = Number(data.@x);
			y = Number(data.@y);
			w = Number(data.@w);
			h = Number(data.@h);
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		/**
		 * set the view of this item to an animation (a vector of textures)
		 * 
		 * @param	textures	the vector of textures containing the sequence for the animating view
		 * @param	fps	the frame rate at which the animation runs
		 */
		public function setViewFromTextures(textures:Vector.<Texture>, fps:Number = 12):void
		{
			if (view) removeChild(view);
			
			view = new MovieClip(textures, fps);
			addChild(view);
			
			Starling.juggler.add(view as MovieClip);
		}
		
		/**
		 * set the view of this item to a fixed texture
		 * 
		 * @param	texture	the texture to use for the view
		 */
		public function setViewFromTexture(texture:Texture):void
		{
			if (view)
				removeChild(view);
			
			view = new Image(texture);
			addChild(view);
		}
		
		/**
		 * set the view of this item using a tile
		 * 
		 * @param	texture	the texture to use for the view
		 */
		public function setViewFromTile(textureTile:TextureTile):void
		{
			textureTile.run(this);
		}
		
		/**
		 * set the view of this item to an image
		 * 
		 * @param	texture	the texture to use for the view
		 */
		public function setViewFromImage(image:Image):void
		{
			if (view)
				removeChild(view);
			
			view = image;
			addChild(view);
		}
		
		/**
		 * draw this item in debug
		 */
		public function drawDebug():void
		{
			viewDebug = new Quad(w, h, drawDebugColor);
			addChildAt(viewDebug, 0);
		}
		
		/**
		 * clear previously drawn debug
		 */
		public function clearDrawDebug():void
		{
			if (viewDebug)
				removeChild(viewDebug);
			
			viewDebug = null;
		}
		
		/** @private */
		protected function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			if (view is MovieClip)
				Starling.juggler.remove(view as MovieClip);
			
			// to be overridden
		}
	}
}