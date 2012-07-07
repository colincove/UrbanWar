package com.weapons{
	import com.weapons.activeWeapon;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.myMath.hitTestLine;
	import com.globals;
	import com.interfaces.activeWeaponInterface;
	import com.globalFunctions;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.displayObjects.activeObj;

	public class TankShell extends activeWeapon implements activeWeaponInterface {
		protected var originPoint:Point;
		protected var originObj:MovieClip;
		public function TankShell(Angle:int, originPoint:Point,primaryHitCheck:MovieClip, arm:MovieClip, attackList:Array, strength:int=20, pointWorth:int=0, isHeroWeapon:Boolean=false):void {
			super(originPoint,primaryHitCheck, strength, null, pointWorth);
			this.originPoint=originPoint;
			this.originObj=arm;
			this.attackList=attackList;
			ground=primaryHitCheck;
			if(strength==20)
			{
			strength=150;
			}
			this.isHeroWeapon=isHeroWeapon;
			fireBullet();
			
		}
		public function impact():void {
		}
		protected function fireBullet():void {
			var xChange:int=Math.cos(originObj.rotation*(Math.PI/180))*50;
			var yChange:int=Math.sin(originObj.rotation*(Math.PI/180))*50;
			var dist:int=hitTestLine.getAngledLine(globalFunctions.getMainX(originObj)+xChange,globalFunctions.getMainY(originObj)+yChange,originObj.rotation,primaryHitCheck,1000,100,true);
			var xPos:int = Math.cos(originObj.rotation*(Math.PI/180))*dist+xChange;
			var yPos:int = Math.sin(originObj.rotation*(Math.PI/180))*dist+yChange;
			globals.trails.graphics.lineStyle(5,0xFFFFFF,1);
			globals.trails.graphics.moveTo(globalFunctions.getMainX(originObj)+xChange,globalFunctions.getMainY(originObj)+yChange);
			globals.trails.graphics.lineTo(globalFunctions.getMainX(originObj)+xPos,globalFunctions.getMainY(originObj)+ yPos);
						var targetObj:activeObj = checkObjDmg(globalFunctions.getMainX(originObj)+xPos,globalFunctions.getMainY(originObj)+yPos);
			if (isHeroWeapon)
			{
				if (targetObj!=null && targetObj!=globals.hero)
				{
					AccuracyStats.addHit();
				}
				else
				{
					AccuracyStats.addMiss();
				}
			}
			var Explosion:tmpDisplayObj = new explosion(globalFunctions.getMainX(originObj)+ xPos,globalFunctions.getMainY(originObj)+ yPos);
		}
		public function removeSelf():void
		{
		}
		public override function destroy():void
		{
			super.destroy();
			originPoint=null;
			originObj=null;
		}
	}
}