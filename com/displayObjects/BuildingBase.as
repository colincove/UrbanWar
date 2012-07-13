package  com.displayObjects {
		import com.displayObjects.activeObj;
	import com.interfaces.dieable;
		import com.Sound.GlobalSounds;
		import com.interfaces.populated;
	import com.globalFunctions;
	import com.globals;
	public class BuildingBase extends activeObj implements dieable {

		public function BuildingBase() 
		{
			// constructor code
			globals.buildings.push(this);
		}
			protected var dieSound:String="WoodCrash";
		protected var numberOfDebry:int=3;

		public function die():void 
		{
			GlobalSounds.playSound(dieSound);
			var points:Points = new Points(healthTot,x,y,true);
			globalFunctions.makeDebry("houseDebry",numberOfDebry,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			parent.removeChild(this);
		}

	}
	
}
