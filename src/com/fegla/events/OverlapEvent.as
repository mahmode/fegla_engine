package com.fegla.events
{
	import starling.events.Event;
	import com.fegla.Overlap;

	public class OverlapEvent extends Event
	{
		public static const OVERLAP_START:String = "overlap_start";
		public static const OVERLAP_END:String = "overlap_end";
		
		public var overlap:Overlap;
		
		public function OverlapEvent(type:String)
		{
			super(type);
			
			overlap = new Overlap();
		}
	}
}