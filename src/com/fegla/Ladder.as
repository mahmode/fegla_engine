package com.fegla 
{
	/**
	 * A ladder allows the hero and enemies to climb/descend platforms
	 */
	public class Ladder extends FeglaItem
	{
		/**
		 * Constructor
		 */
		public function Ladder(data:XML)
		{
			super(data);
			
			drawDebugColor = 0xff9900;
		}
	}
}