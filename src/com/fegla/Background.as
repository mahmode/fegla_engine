package com.fegla 
{
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * World background, it can holds several background layers, each layer can have its independent parallax value.
	 */
	public class Background extends Sprite
	{
		private var view:Sprite;
		
		private var world:World;
		private var colorQuad:Quad;
		
		/**
		 * Constructor
		 * 
		 * @param	world the fegla world
		 */
		public function Background(world:World)
		{
			this.world = world;
			
			view = new Sprite();
			addChild(view);
		}
		
		/**
		 * add a layer to the background, each layer can have its own parallax value
		 * 
		 * @param	texture the background layer texture
		 * @param	parallax the parallax value of the layer, parallax defines how fast the background layer moves relative to the level scrolling speed.
		 * @param	overlap the amount of overlap between 2 adjacent repeated textures. Normally you do not need to change this value. But
		 */
		public function addLayer(texture:Texture, parallax:Number = 0, overlap:Number = 0):void
		{
			var layer:BackgroundLayer = new BackgroundLayer(world, texture, parallax, overlap);
			view.addChild(layer);
		}
		
		/**
		 * set a solid color for the background
		 * @param	color	the color to set for the background
		 */
		public function setColor(c:int):void 
		{
			if (!colorQuad)
			{
				colorQuad = new Quad(world.levelWidth, world.levelHeight, c);
				addChild(colorQuad);
			}
			else
			{
				colorQuad.color = c;
			}
		}
		
		/** @private */
		internal function update():void
		{
			var layer:BackgroundLayer;
			for (var i:int = 0; i < view.numChildren; i++)
			{
				layer = view.getChildAt(i) as BackgroundLayer;
				layer.x = (world.view.x * layer.parallax) % layer.effectiveWidth;
				layer.y = (world.view.y * layer.parallax) % layer.effectiveHeight;
			}
		}
	}
}