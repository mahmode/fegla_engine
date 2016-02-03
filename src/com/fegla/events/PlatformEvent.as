package com.fegla.events
{
	import com.fegla.Platform;
	import starling.events.Event;

	public class PlatformEvent extends Event
	{
		public static const TOUCH_FLOOR:String = "touch_floor";
		public static const LEAVE_FLOOR:String = "leave_floor";
		
		public var platform:Platform;
		
		public function PlatformEvent(type:String)
		{
			super(type);
		}
	}
}