package com.displayObjects{
	import com.displayObjects.activeObj;
	import com.interfaces.dieable;
		import com.interfaces.populated;
	import com.globalFunctions;
	public class Building extends activeObj implements dieable, populated {
		public function Building():void {
		}
		public function die():void {
			globalFunctions.makeDebry("houseDebry",10,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			parent.removeChild(this);
		}
	}
}
