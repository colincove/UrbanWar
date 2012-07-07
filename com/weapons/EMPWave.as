package  com.weapons 
{
	import com.interfaces.activeWeaponInterface;
	import com.interfaces.Program;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.globals;
	
	import com.globalFunctions;
	public class EMPWave extends activeWeapon implements activeWeaponInterface,Program 
	{
private var hitHero:Boolean=false;
		public function EMPWave(Angle:int, originPoint:Point,primaryHitCheck:MovieClip,attackList:Array, strength:int=20, pointWorth:int=0) 
		{
			// constructor code
			super(originPoint,primaryHitCheck, strength,primaryHitCheck, pointWorth);
			this.attackList=attackList;
			ground=primaryHitCheck;
			globals.game_progThread.addProg(this);
			//selfReferance=this;
			progRun=true;
			x=originPoint.x;
			y=originPoint.y;
		}
public function update():Object 
		{
			if(this.hitTestPoint(globalFunctions.getMainX(globals.hero),globalFunctions.getMainY(globals.hero),true) && !hitHero)
			{
				hitHero=true;
				globals.hero.EMP();
			}
			if(currentFrame==totalFrames)
			{
				removeSelf();
			}
			return this;
		}
		public function impact():void
		{
			
		}
		public function removeSelf():void {
			globals.game_progThread.removeProg(this);
			//removeProjectile();
			parent.removeChild(this);
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
	
}
