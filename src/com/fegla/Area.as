package com.fegla 
{
	/**
	 * Define an area in the level that can fire events when the hero enters/leaves it. Also the area can have differnet viscosity to simulate water, oil...etc
	 */
	public class Area extends FeglaItem
	{
		/**
		 * The viscosity of the area, setting the viscosity below 1 makes the area thicker (slow movement). This is useful for simulating the hero entering water, oil, sand...etc
		 */
		public var viscosity:Number = 1;
		
		/**
		 * When true the hero can jump while sinking in this area
		 */
		public var allowJump:Boolean = false;
		
		/**
		 * Constructor
		 * 
		 * @param	data the data xml node to populate this area properties
		 */
		public function Area(data:XML)
		{
			super(data);
			
			if (data.@v.length() > 0 && Number(data.@v) != 1)
				viscosity = Number(data.@v);
			
			if (data.@j.length() > 0 && Number(data.@j) == 1)
				allowJump = true;
			
			drawDebugColor = 0x663300;
		}
	}
}