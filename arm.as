package {
	import com.globals;
	import flash.events.Event;
	import com.myMath.myAngle;
	import com.globalFunctions;
	import com.interfaces.removable;
	import flash.events.KeyboardEvent;
	import com.interfaces.Program;

	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.MovieClip;
	public class arm extends weaponControl implements removable,Program {
		private var parentClip:MovieClip;
		
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function arm(parentClip:MovieClip):void 
		{
			barrelPoint = new Point();
			this.parentClip=parentClip;
			globals.static_progThread.addProg(this);
			progRun=true;
		}
		public override  function destroy():void
		{
			removeSelf();
		}
		public function removeSelf():void {
			stopShoot();
			globals.main.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseClick, false);
			globals.main.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUnClick, false);
			globals.main.removeEventListener(MouseEvent.MOUSE_WHEEL, scrollUp, false);
			globals.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, checkWeaponSwitch, false);
		}
		public function armRotation():void 
		{
			if(progRun)
			{
				var xComp:Number  = Math.cos(rotation*(Math.PI/180))*20;
				var yComp:Number  = Math.sin(rotation*(Math.PI/180))*20;
			barrelPoint.x=globalFunctions.getMainX(this)+xComp;
			barrelPoint.y=globalFunctions.getMainY(this)+yComp;
			x=15;
			y=-50;
			if (selectedWeapon!=null) {
				var armAngle:int=myAngle.getAngle(globalFunctions.getLevelX(this),globals.main.stage.mouseX,globalFunctions.getLevelY(this),globals.main.stage.mouseY);
				if (selectedWeapon.isHeavy()&&selectedWeapon.isShooting())
				{
					rotation+=myAngle.angleDiff(rotation,armAngle)/selectedWeapon.heavyWpnWeight;
				} else {
					rotation=armAngle;
				}
			}
			}
		}
		public function resumeArmFunction():void
		{
						//reverse of removeSelf()
			globals.main.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseClick, false);
			globals.main.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUnClick, false);
			globals.main.addEventListener(MouseEvent.MOUSE_WHEEL, scrollUp, false);
			globals.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, checkWeaponSwitch, false);
			weaponNum=0;
			changeWeapon();
		}
		public function update():Object {
			armRotation();
			if (selectedWeapon!=null) {
				makeSteam(selectedWeapon.getHeat()/selectedWeapon.getHeatCapacity());
			}
			return this;
		}
		private function mouseClick(e:MouseEvent):void {
			
			if(progRun && !globals.hideUI){
			shoot(barrelPoint);
			}
		}
		public function isRunning():Boolean {
			
			return progRun;
		}
		private function mouseUnClick(e:MouseEvent):void 
		{
			if(progRun && !Hero.disableHero){
			stopShoot();
			}
		}
	}
}