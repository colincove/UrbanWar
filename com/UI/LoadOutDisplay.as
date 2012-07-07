package com.UI  {
	import flash.display.MovieClip;
	import com.events.MenuEvent;
	import com.database.Result;
	
	public class LoadOutDisplay extends MovieClip 
	{

		public function LoadOutDisplay() 
		{
			GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE,update);
			// constructor code
		}
		private function update(e:MenuEvent=null):void 
		{
			for(var i:int=0;i<3;i++)
			{
				if(i<GameMenuPM.loadOut.length)
				{
					//I need to display a weapon.
					this["wpn"+(i+1)].gotoAndStop(Result.findFrame(GameMenuPM.loadOut[i].weaponType));
				}else{
					//there is no weapon to display. 
					this["wpn"+(i+1)].gotoAndStop(1);
				}
			}
		}

	}
	
}
