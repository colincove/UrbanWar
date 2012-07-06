package com.weapons{
	import flash.events.Event;
	import com.weapons.activeWeapon;
	import flash.display.MovieClip;
	import flash.geom.Point;
		import com.displayObjects.Points;

	import flash.media.SoundChannel;
	import com.Sound.GlobalSounds;
	import com.displayObjects.activeObj;
	import com.weapons.ExtendedFireWeapon;
	import com.myMath.hitTestLine;
	import com.globals;
	import com.interfaces.Program;
	import com.globalFunctions;
	public class Laser extends activeWeapon implements Program {
		protected var originPoint:Point;
		protected var originObj:MovieClip;
		protected var pointInterval:int;
		private var soundChannel:SoundChannel;
		private var weapon:ExtendedFireWeapon;
		protected var bulletArtwork:MovieClip;
		protected var hitGraphicList:Array;//contains the list of laser hit graphics. Will always have 10 in it. Any more and I dont really want them. 
		public function Laser(Angle:int, originPoint:Point,primaryHitCheck:MovieClip, arm:MovieClip, weapon:ExtendedFireWeapon, strength:int=20, pointWorth:int=0):void {
			super(originPoint,primaryHitCheck, strength, null, pointWorth);
			this.originPoint=originPoint;
			this.originObj=arm;
			this.weapon=weapon;
			createHitGraphicList();
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public override function destroy():void{
			super.destroy();
			originPoint=null;
			originObj=null;
			soundChannel=null;
			weapon=null;
			if(bulletArtwork!=null)
			{
				if(bulletArtwork.parent!=null)
				{
					bulletArtwork.parent.removeChild(bulletArtwork);
				}
			}
			if(hitGraphicList!=null){
			hitGraphicList.slice(0);
			}
			hitGraphicList=null;
		}
		private function createHitGraphicList():void {
			hitGraphicList=new Array();
			for (var i:int=0; i<10; i++) {
				hitGraphicList[i]=new laserHit();
				globals.main.addChild(hitGraphicList[i]);
			}
		}
		public function isRunning():Boolean {
			return progRun;
		}
		public function update():Object {
			fireBullet();
			weapon.heatUp();
			return this;
		}
		public function impact():void {
		}
		////
		//Old code that made the laser work more like a stronger Mini Gun. 
		/*protected function fireBullet():void {
		if (bulletArtwork.parent==null) {
		globals.levelObj.addChild(bulletArtwork);
		globals.smoke.laserBM.addDrawObj(bulletArtwork);
		}
		var xChange:int=Math.cos(originObj.rotation*(Math.PI/180))*50;
		var yChange:int=Math.sin(originObj.rotation*(Math.PI/180))*50;
		bulletArtwork.hitSpot.gotoAndPlay('fire');
		bulletArtwork.trail.gotoAndPlay('fire');
		bulletArtwork.x=globalFunctions.makeX(bulletArtwork,originPoint.x+xChange);
		bulletArtwork.y=globalFunctions.makeY(bulletArtwork,originPoint.y+yChange);
		x=originPoint.x+xChange;
		y=originPoint.y+yChange;
		var dist:int=hitTestLine.getAngledLine(globalFunctions.getMainX(this), globalFunctions.getMainY(this),originObj.rotation,primaryHitCheck,1000,100, true);
		bulletArtwork.trail.rotation=originObj.rotation;
		bulletArtwork.hitSpot.rotation=originObj.rotation;
		bulletArtwork.StreakMask.MaskArtwork.x=-dist;
		bulletArtwork.StreakMask.rotation=originObj.rotation+180;
		var xPos:int = Math.cos(originObj.rotation*(Math.PI/180))*dist;
		var yPos:int = Math.sin(originObj.rotation*(Math.PI/180))*dist;
		bulletArtwork.hitSpot.x=xPos;
		bulletArtwork.hitSpot.y=yPos;
		checkObjDmg(globalFunctions.getMainX(this)+xPos,globalFunctions.getMainY(this)+yPos);
		}*/
		protected function fireBullet():void
		{
			if (bulletArtwork.parent==null)
			{
				globals.levelObj.addChild(bulletArtwork);
				globals.smoke.smokeBM.addDrawObj(bulletArtwork);
			}
			var xChange:int=Math.cos(originObj.rotation*(Math.PI/180))*50;
			var yChange:int=Math.sin(originObj.rotation*(Math.PI/180))*50;
			bulletArtwork.hitSpot.gotoAndPlay('fire');
			bulletArtwork.trail.gotoAndPlay('fire');
			bulletArtwork.x=globalFunctions.makeX(bulletArtwork,originPoint.x+xChange);
			bulletArtwork.y=globalFunctions.makeY(bulletArtwork,originPoint.y+yChange);
			x=originPoint.x+xChange;
			y=originPoint.y+yChange;
			//var dist:int=hitTestLine.getAngledLine(globalFunctions.getMainX(this),globalFunctions.getMainY(this),originObj.rotation,primaryHitCheck,1000,50,true);
			var dist:int=getAngledLineDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this),originObj.rotation,primaryHitCheck,800,40,true);

			bulletArtwork.trail.rotation=originObj.rotation;
			bulletArtwork.hitSpot.rotation=originObj.rotation;
			bulletArtwork.StreakMask.MaskArtwork.x=- dist;
			bulletArtwork.StreakMask.rotation=originObj.rotation+180;
			var xPos:int = Math.cos(originObj.rotation*(Math.PI/180))*dist;
			var yPos:int = Math.sin(originObj.rotation*(Math.PI/180))*dist;
			bulletArtwork.hitSpot.x=xPos;
			bulletArtwork.hitSpot.y=yPos;
			/*for (var i:int=0; i<dist; i+=30) {
			xPos = Math.cos(originObj.rotation*(Math.PI/180))*i;
			yPos = Math.sin(originObj.rotation*(Math.PI/180))*i;
			var tmpObj:activeObj=findDmgObj(xPos,yPos,attackList);
			if (tmpObj!=null) {
			doDamage(xPos, yPos, tmpObj, strength);
			}
			}*/
			//checkObjDmg(globalFunctions.getMainX(this)+xPos,globalFunctions.getMainY(this)+yPos);
		}
		public function removeSelf():void {
			
			try{
			for (var h:int=0; h<hitGraphicList.length; h++) {
				hitGraphicList[h].visible=false;
				hitGraphicList[h].parent.removeChild(hitGraphicList[h]);
				hitGraphicList[h]=null;
			}
			hitGraphicList=null;
			globals.game_progThread.removeProg(this);
			globals.smoke.smokeBM.removeDrawObj(bulletArtwork);
			if (bulletArtwork.parent!=null) {
				bulletArtwork.parent.removeChild(bulletArtwork);
			}}catch(e:Error){
			
			}
			destroy();
		}
		public function laserHitCheck():void {
		}
		public function getAngledLineDmg(startX:int, startY:int, myAngle:int,testObj:MovieClip,dist:int, testPoints:int, sight:Boolean=false):int {
			//I had to make sight for bullets. with sight set to false, the method goes for the entire loop and counts all the hits. if set to true, 
			//the method will exit at the first hit, calculating the distance from the object to the wall. 
			var lineVar:int=0;
			for (var h:int=0; h<hitGraphicList.length; h++) {
				hitGraphicList[h].visible=false;
			}
			var hitList:Array = new Array();
			var xPos:Number = Math.cos(myAngle*(Math.PI/180));
			var yPos:Number = Math.sin(myAngle*(Math.PI/180));
			for (var i:int=dist/testPoints; i<dist; i+=dist/testPoints) 
			{
				var xComp:Number=xPos*i+startX;
				var yComp:Number=yPos*i+startY;
				lineVar+=dist/testPoints;
				if (! globals.HUD.hitTestPoint(xComp,yComp,true))
				{
										AccuracyStats.addMiss();

					break;
				}
				if (testObj.hitTestPoint(xComp,yComp,true)) {//This for whenever it hits comething of interest. This could be the ground or an enemy. I dont really know which though. 
					if (globals.heroContainer.hitTestPoint(xComp,yComp,true)) {//here is where I check if it hit the ground. In whicn case, the laser should stop.
					AccuracyStats.addMiss();
						return i;
					}
					//but if I did in fact hit something, but NOT the ground, then I probably hit an enemy or a building. Something that needs to take damage. 
					//var tmpObj:activeObj=findDmgObj(xComp,yComp,attackList);I find the object that i hit. findDmgObj is on activeObj.
					var tmpObj:activeObj=findDmgObj(xComp,yComp,globals.activeObjectList);//I find the object that i hit. findDmgObj is on activeObj.
					if (tmpObj!=null) {//If tmpObj was null, then for some reason I did not hit something. But if its not null, then I did in fact hit something.
					AccuracyStats.addHit();
						var onList:Boolean=false;//variables used to determine whether I have already delth damage to that particular enemy already. 
						for (var j:int=0; j<hitList.length; j++) {//need to see if i alrerady hit that enemy. I only want to hit every object once. 
							if (hitList[j]==tmpObj) {
								onList=true;
								break;
							}
						}


						if (! onList) {//finnaly, If that object was not on the list already, I need to do damage to it and add it to the list of hit objects.
							if (hitList.length<hitGraphicList.length) {
								hitGraphicList[hitList.length].x=xComp;
								hitGraphicList[hitList.length].y=yComp;
								globals.main.addChild(hitGraphicList[hitList.length]).visible=true;
							}
							i+=20;
							tmpObj.x+=.5;
							hitList.push(tmpObj);
							Points.displayPoint(pointWorth,xComp-globals.neutralContainer.x,yComp-globals.neutralContainer.y);
							//var points:Points=new Points(Math.random()*1000,xComp-globals.neutralContainer.x,yComp-globals.neutralContainer.y);

							doDamage(xComp, yComp, tmpObj, strength);
						}
					} else {

					}
				}
			}
			if (lineVar==0) {
				lineVar=dist;
			}
			return lineVar;
		}
	}
}