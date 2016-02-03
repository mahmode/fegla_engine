package com.fegla 
{
	import starling.textures.Texture;
	/**
	 * A ladder allows the hero and enemies to climb/descend platforms
	 */
	public class ImageItem extends FeglaItem
	{
		/**
		 * Constructor
		 */
		public function ImageItem(data:XML)
		{
			super(data);
			
			drawDebugColor = 0x9900ff;
		}
		
		public override function setViewFromTexture(texture:Texture):void
		{
			super.setViewFromTexture(texture);
			
			view.pivotX = view.width / 2;
			view.pivotY = view.height;
			
			w = view.width;
			h = view.height;
		}
	}
}