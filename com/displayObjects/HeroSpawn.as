package com.displayObjects {
	import com.globals;
	import flash.display.MovieClip;
	import flash.events.Event;

	
	public class HeroSpawn extends MovieClip
	{
		

		public function HeroSpawn() 
		{
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
private function addedToStage(e:Event):void
{
		globals.hero.x=x;
	globals.hero.y=y;
	parent.addChild(globals.hero);
	globals.hero.resetHero();
	globals.heroList.push(globals.hero);

			globals.hero.progRun=true;
			parent.removeChild(this);
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
}
	}
	
}
