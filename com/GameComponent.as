package com{
	import flash.display.MovieClip;
	public class GameComponent extends MovieClip
	{
		public function GameComponent():void
		{
			super();
			globals.gameComponentList.push(this);
		}
		public function destroy():void
		{
			
			removeChildrenUtil.removeAllChildren(this);
			if(parent!=null)
			{
				parent.removeChild(this);
			}
			
		}
		public function semiDestroy():void
		{
			
		}
	}
}