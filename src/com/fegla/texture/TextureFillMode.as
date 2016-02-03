package com.fegla.texture 
{
	/**
	 * Values of texturing mode for fegla items
	 * 
	 */
	public class TextureFillMode
	{
		/**
		 * No fill. put the texture as is on the fegla item
		 */
		public static const NONE:String = "none";
		
		/**
		 * Stretch the texture to fill the item width and height
		 */
		public static const STRETCH:String = "stretch";
		
		/**
		 * Stretch the texture horizontally to fill the item width but leave the height as is
		 */
		public static const STRETCH_X:String = "stretch_x";
		
		/**
		 * Stretch the texture vertically to fill the item height but leave the width as is
		 */
		public static const STRETCH_Y:String = "stretch_y";
		
		/**
		 * Repeat the texture in both directions to fill the item width and height
		 */
		public static const REPEAT:String = "repeat";
		
		/**
		 * Repeat the texture horizontally to fill the item width but leave the height as is
		 */
		public static const REPEAT_X:String = "repeat_x";
		
		/**
		 * Repeat the texture vertically to fill the item height but leave the width as is
		 */
		public static const REPEAT_Y:String = "repeat_y";
		
		public function TextureFillMode() 
		{
			
		}
	}
}