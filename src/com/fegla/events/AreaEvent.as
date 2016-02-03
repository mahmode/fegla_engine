package com.fegla.events
{
	import com.fegla.Area;
	import starling.events.Event;

	public class AreaEvent extends Event
	{
		public static const ENTER_AREA:String = "enter_area";
		public static const LEAVE_AREA:String = "leave_area";
		
		public var area:Area;
		
		public function AreaEvent(type:String)
		{
			super(type);
		}
	}
}