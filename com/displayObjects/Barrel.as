package com.displayObjects{
	import com.displayObjects.activeObj;
	import com.interfaces.dieable;
		import com.interfaces.populated;
		import com.physics.objMovement;
		import com.globals;
		import com.interfaces.Program;
	import com.globalFunctions;
	import flash.events.Event;

	public class Barrel extends   BuildingBase 
	{
		
		public function Barrel():void 
		{
			this.dieSound="BarrelExplode";
			this.numberOfDebry=2;
			//ground=globals.groundContainer;
			//globals.game_progThread.addProg(this);
			this.addEventListener(Event.REMOVED_FROM_STAGE, barrelRemoved);
		}
public function update():Object 
{
	//checkScreen();
			//movementUpdate();
			//moveObj();
			//gravPull();
			return this;
		}
		private function barrelRemoved(e:Event):void{
						var Explosion:tmpDisplayObj=new explosion(globalFunctions.getMainX(this)+15,globalFunctions.getMainY(this));
						Explosion=new explosion(globalFunctions.getMainX(this)-8,globalFunctions.getMainY(this)+5);
						Explosion=new explosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this)-20);
this.removeEventListener(Event.REMOVED_FROM_STAGE, barrelRemoved);
		}
		
	}
}
