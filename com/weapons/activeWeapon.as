package com.weapons
{
	import com.globals;
	import com.globalFunctions;
	import com.physics.gravity;
	import flash.geom.Point;
	import com.myMath.dist;
	import com.displayObjects.activeObj;
	import com.displayObjects.Points;
	import flash.display.MovieClip;
	public class activeWeapon extends gravity
	{
		private var hitCheck:pointOfDamage;
		protected var strength:int;
		protected var fireDelay:int;
		protected var radius:int;
		//protected var originPoint:Point;
		protected var attackList:Array;
		protected var primaryHitCheck:MovieClip;
		protected var secondaryHitCheck:MovieClip;
		private var _isHeroWeapon:Boolean = false;

		public function activeWeapon( originPoint:Point,primaryHitCheck:MovieClip, strength:int=20, secondaryHitCheck:MovieClip=null, pointWorth:int=0):void
		{
			this.strength = strength;
			this.primaryHitCheck = primaryHitCheck;
			this.secondaryHitCheck = secondaryHitCheck;
			if (primaryHitCheck!=null)
			{
				hitCheck = new pointOfDamage(this,primaryHitCheck);
			}
			globals.activeWeaponList.push(this);
			globals.levelObj.addChild(this);
			this.pointWorth = pointWorth;
		}
		public function get isHeroWeapon():Boolean
		{
			return _isHeroWeapon;
		}
		public function set isHeroWeapon(value:Boolean):void
		{
			_isHeroWeapon=value;
		}
		public override function destroy():void
		{
			super.destroy();
			if (hitCheck!=null)
			{
				hitCheck.destroy();
			}
			hitCheck = null;
			primaryHitCheck = null;
			secondaryHitCheck = null;
			attackList = null;
		}
		public function getGnd():MovieClip
		{
			return ground;
		}
		protected function doDamage(xPos:int, yPos:int,obj:activeObj, strength:int):void
		{
			if ((obj==globals.hero && !this.isHeroWeapon) || (obj!=globals.hero))
			{
				obj.hit(xPos, yPos,strength);
			}
		}
		protected function findDmgObj(xPos:int, yPos:int, list:Array):activeObj
		{
			for (var i:int=0; i<list.length; i++)
			{
				if (list[i].hitTestPoint(xPos,yPos,true))
				{
					if (this!=list[i])
					{
						return list[i];

					}
				}
			}
			return null;
		}
		protected function checkObjDmg(xPos:int,yPos:int):activeObj
		{
			if (attackList==globals.enemyList)
			{
				
				attackList = globals.activeObjectList;
			}
			var tmpObj:activeObj = findDmgObj(xPos,yPos,attackList);
			if (tmpObj!=null)
			{
				if (tmpObj==globals.hero)
				{
					if (weaponControl.containsProjectile(this))
					{
						return globals.hero;
					}
				}
				//if the target is the hero and this is a hero weapon, then dont do damage. 
				//otherwise, just do thr damage. 
				doDamage(xPos, yPos, tmpObj, strength);
				if (primaryHitCheck==globals.enemyContainer)
				{
					Points.displayPoint(pointWorth,xPos - globals.neutralContainer.x,yPos - globals.neutralContainer.y);
					//var points:Points = new Points(pointWorth,xPos - globals.neutralContainer.x,yPos - globals.neutralContainer.y);
				}


				return tmpObj;
			}
			else
			{
				return null;
			}
			return null;
		}
		/*Old code that works different from the new system. 
		protected function checkObjDmg(xPos:int,yPos:int):void {
		if (attackList==globals.enemyList) {
		attackList=globals.activeObjectList;
		
		}
		for (var i:int=0; i<attackList.length; i++) {
		if (attackList[i].hitTestPoint(xPos,yPos,true)) {
		if (this!=attackList[i]) {
		var points:Points=new Points(Math.random()*1000,xPos-globals.neutralContainer.x,yPos-globals.neutralContainer.y);
		attackList[i].hit(xPos, yPos,strength);
		}
		}
		}
		}
		*/
		protected function checkAreaDmg(xPos:int,yPos:int):void
		{
			if (attackList==globals.enemyList)
			{
				attackList = globals.activeObjectList;

			}
			for (var i:int =0; i<attackList.length; i++)
			{
				var distance:int = dist.getObjDist(this,attackList[i]);
				if (distance<radius)
				{
					attackList[i].hit(xPos, yPos,strength);
				}
			}
			/*
			for (var i:int=0; i<attackList.length; i++) {
			if (attackList[i].hitTestPoint(xPos,yPos,true)) {
			if(this!=attackList[i]){
			var points:Points = new Points(Math.random()*1000,xPos-globals.neutralContainer.x, yPos-globals.neutralContainer.y);
			attackList[i].hit(xPos, yPos,strength);
			}
			}
			}*/
		}

	}
}