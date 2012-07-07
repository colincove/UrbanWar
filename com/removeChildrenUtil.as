package com
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;

	public class removeChildrenUtil
	{


		public static function removeAllChildren(parentChild:*):void
		{
			if(!(parentChild is Hero)){
			for (var i:uint = 0; i < parentChild.numChildren; ++i)
			{
				//check if child is a DisplayObjectContainer, which could hold more children
				if (parentChild.getChildAt(i) is DisplayObjectContainer)
				{
					removeAllChildren(DisplayObjectContainer(parentChild.getChildAt(i)));
				}
				else
				{
					//remove and null child of parent
					var child:DisplayObject = parentChild.getChildAt(i);
					parentChild.removeChild(child);
					child = null;
				}

			}
			if(parentChild.parent!=null){
			//remove and null parent
			parentChild.parent.removeChild(parentChild);
			}
			parentChild = null;
			}
		}
	}

}