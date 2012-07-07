package com.weapons{
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.globalFunctions;
	import com.weapons.activeWeapon;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.interfaces.activeWeaponInterface;
	import com.interfaces.Program;
	import com.displayObjects.Points;
	import com.physics.Constrain;
	import com.displayObjects.activeObj;
	import com.physics.pointmass;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Vine extends projectile implements activeWeaponInterface,Program {
		private var pointArray:Array;
		private var cArray:Array;
		private var deathInterval:int;
		private var targetObj:activeObj;
		private var xDist:int;
		private var interval:int;
		private var yDist:int;
		private var limp:Boolean;
		
		private var latched:Boolean;
		public function Vine(Angle:int, originPoint:Point,primaryHitCheck:MovieClip,attackList:Array, strength:int=20, density:int=20,degree:int=20, pointWorth:int=0, fireDelay:int=4):void {
			super(Angle,30,originPoint,primaryHitCheck, strength, pointWorth);
			this.attackList=attackList;
			ground=primaryHitCheck;
			this.fireDelay=fireDelay;
			globals.game_progThread.addProg(this);
			progRun=true;
			pointArray=makeRope();
			cArray=makeConstrain(pointArray);
		}
		public override function destroy():void
		{
			super.destroy();
			targetObj=null;
			if(pointArray!=null)
			{
			pointArray.slice(0);
			}
			if(cArray!=null){
			cArray.slice(0);
			}
			pointArray=null;
			cArray=null;
		}
		private function makeConstrain(pointArray:Array):Array
		{
			var tmpArray:Array = new Array();
			for (var i:int=1; i<pointArray.length; i++) 
			{
				var c:Constrain=new Constrain(pointArray[i-1],pointArray[i],20);
				tmpArray.push(c);
			}
			return tmpArray;
		}
		private function makeRope():Array
		{
			var tmpArray:Array = new Array();
			for (var i:int=0; i<7; i++)
			{
				var mass:pointmass=new pointmass(globals.hero.x,globals.hero.y);
				globals.hero.parent.addChild(mass);
				mass.visible=false;
				tmpArray.push(mass);
			}
			return tmpArray;
		}
		public function update():Object {
			globals.neutralContainer.graphics.lineStyle(4,0xFFFFFF,1);
			if (latched&&! limp) {
				if (targetObj.isDead()) {
					interval++;
					x=globalFunctions.getMainX(targetObj)+xDist;
					y=globalFunctions.getMainY(targetObj)+yDist;
					if (interval>4) {
						var points:Points=new Points(pointWorth,x-globals.neutralContainer.x,y-globals.neutralContainer.y);
						doDamage(x, y,targetObj, strength);
						globals.neutralContainer.graphics.lineStyle(10,0xFFFFFF,1);
						globals.trails.graphics.lineStyle(4,0xFFFFFF,.2);
						globals.trails.graphics.moveTo(globalFunctions.getMainX(pointArray[0]), globalFunctions.getMainY(pointArray[0]));
						interval=0;
					}
				} else {
					limp=true;
				}
			}
			moveObj();
			if (! limp) 
			{
				checkScreen();
				if(!onScreen)
				{
					AccuracyStats.addMiss();
					limp=true;
				}else{
				pointArray[0].x=globals.hero.x;
				pointArray[0].y=globals.hero.y;
				pointArray[pointArray.length-1].x=x-globals.hero.parent.x;
				pointArray[pointArray.length-1].y=y-globals.hero.parent.y;
				}
			} else {
				deathInterval++;
				if (deathInterval==4) {
					if (pointArray.length>1) {
						pointArray.splice(0,1);
					} else {
						removeSelf();
					}
					deathInterval=0;
				}
			}
			
			globals.trails.graphics.lineStyle(4,0xFFFFFF,.2);
			globals.neutralContainer.graphics.moveTo(pointArray[0].x, pointArray[0].y);
			globals.trails.graphics.moveTo(globalFunctions.getMainX(pointArray[0]), globalFunctions.getMainY(pointArray[0]));
			for (var i:int=1; i<pointArray.length; i++) {
				if (interval==0) 
				{
					globals.trails.graphics.lineTo(globalFunctions.getMainX(pointArray[i]), globalFunctions.getMainY(pointArray[i]));
				}
				globals.neutralContainer.graphics.lineTo(pointArray[i].x, pointArray[i].y);
				pointArray[i].update();
			}
			for (var j:int=0; j<cArray.length; j++) 
			{
				cArray[j].update();
			}
			return this;
		}
		public function impact():void {
			if (! latched) {
				targetObj=findDmgObj(globalFunctions.getMainX(this),globalFunctions.getMainY(this),globals.activeObjectList);

				if (targetObj!=null && targetObj!=globals.hero) 
				{
					xDist=globalFunctions.getMainX(this)-globalFunctions.getMainX(targetObj);
					yDist=globalFunctions.getMainY(this)-globalFunctions.getMainY(targetObj);
					AccuracyStats.addHit();
					GlobalSounds.playSound('VineHit');
				} else {
					AccuracyStats.addMiss();
					limp=true;
				}
				Speed=0;
				xSpeed=0;
				ySpeed=0;
				//GlobalSounds.playSound('explosion1');
				//checkObjDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this));

				latched=true;
			}
		}
		public function removeSelf():void {

			globals.game_progThread.removeProg(this);
			parent.removeChild(this);
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
}