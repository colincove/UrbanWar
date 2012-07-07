package com.items {
	import com.interfaces.Program;
	import flash.display.MovieClip;
	import com.globals;
	public class FloatingItem  extends Item implements Program 
	{
		public var yPos:int;
		private var ySpeed:Number;
		public function FloatingItem(radius:int, actionClip:MovieClip)
		{
			super(radius,actionClip);
			yPos=y;
			ySpeed=-1;
			globals.game_progThread.addProg(this);
			progRun=true;
			// constructor code
		}
	override public function update():Object
	{
			y+=ySpeed;
			if(y>yPos){
				ySpeed-=.05;
			}else{
				ySpeed+=.05;
			}
			itemUpdate();
			return this;
		}
	}
	
}
