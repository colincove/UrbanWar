package com.displayObjects{
	import com.displayObjects.activeObj;
	import com.interfaces.dieable;
	import com.interfaces.removable;
	import com.interfaces.Program;
		import com.interfaces.populated;
	import com.globalFunctions;
	import com.globals;
	import flash.events.Event;
	public class Car extends BuildingBase implements  populated, removable, Program  
	{
		private var progRun:Boolean;
		public function Car():void
		{
			globals.game_progThread.addProg(this);
			progRun=true;
			health=20;
			pointWorth=60;
			this.numberOfDebry=2;
			dieSound="CarCrash";
		}
		public function removeSelf():void
		{
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		public function update():Object 
		{
			if(this.hitTestPoint(globalFunctions.getMainX(globals.hero), globalFunctions.getMainY(globals.hero)+50, true)){
				if(globals.hero.getYSpeed()>5){
								var points:Points=new Points(Math.random()*1000,x,y);
					die();
				}
			}
			return this;
		}
	}
}
