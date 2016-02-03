package com.fegla 
{
	import starling.display.DisplayObject;
	public class Overlap 
	{
		public var groupId1:String;
		public var groupId2:String;
		public var item1:DisplayObject;
		public var item2:DisplayObject;
		
		public function Overlap(item1:DisplayObject = null, item2:DisplayObject = null)
		{
			this.item1 = item1;
			this.item2 = item2;
		}
		
		public function itemExist(item:DisplayObject):Boolean
		{
			return (item == item1 || item == item2);
		}
		
		public function itemsExist(item1:DisplayObject, item2:DisplayObject):Boolean
		{
			return (item1 == this.item1 && item2 == this.item2) || (item2 == this.item1 && item1 == this.item2);
		}
	}
}