package com
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import com.levels.level;
	import com.Prog;
import com.levels.LevelEnd;
	import com.ProgThread;
	import com.camera.Cam;
	import com.displayObjects.Smoke;
	import com.displayObjects.Steam;
	import com.weapons.*;
	import com.displayObjects.BuildingBase;
	import com.levels.GroundControl;
	import com.displayObjects.debry;
	import com.weapons.activeWeapon;
	import flash.utils.Dictionary;
	import com.controllers.GradingScaleController;


	public class globals
	
	{
		public static var enemiesKilled:int=0;
		public static var accuracy:AccuracyStats = new AccuracyStats();
		public static var gradingScaleController:GradingScaleController;
		public static var groundControl:GroundControl;
		public static var overlayLayer:MovieClip= new MovieClip();
		//level lists
		public static var buildings:Vector.<BuildingBase> = new Vector.<BuildingBase>;
		public static var debryList:Vector.<debry> = new Vector.<debry>;
		public static var activeWeaponList:Vector.<activeWeapon> = new Vector.<activeWeapon>;
		public static var gameComponentList:Vector.<GameComponent> = new Vector.<GameComponent>;
		/////Program Variables
		public static var prog:Prog;
		//
		public static var key:Object = new Object();
		public static var globalDictionary:Dictionary = new Dictionary(true);
	
		public static var game_progThread:ProgThread;
		public static var menus_progThread:ProgThread;
		public static var static_progThread:ProgThread;
		////
		public static var endLevelObject:LevelEnd;
		public static var levelProgress:int = 1;
		public static var gamePause:Boolean;
		public static var gameVars:Object;
		public static var HUD:Cam;
		public static var camSpeed:int;
		public static var main:MovieClip;
		public static var gravity:Number;
		public static var levelObj:MovieClip;
		public static var fric:Number;
		public static var hero:Hero;
		public static var heroArm:MovieClip;
		public static var heroContainer:MovieClip;
		public static var neutralContainer:MovieClip;
		public static var enemyContainer:MovieClip;
		public static var groundContainer:MovieClip;
		public static var emptyGround:MovieClip;
		public static var gameWidth:int = 800;
		public static var points:int;
		public static var gameHeight:int = 600;
		public static var activeObjectList:Array;
		public static var enemyList:Array;
		public static var heroList:Array;
		public static var people:Array;
		public static var smoke:Smoke;
		public static var steam:Steam;
		public static var score:MovieClip;
		public static var trails:MovieClip;
		
		public static var letPlayerLive:Boolean=false;
		
		public static var defaultWeaponsLoaded:Boolean = false;
		
		public function globals():void
		{
		}
		public static function resetLists():void
		{
			endLevelObject=null;
			for each (var debryPiece:debry in debryList)
			{
				debryPiece.destroy();
			}
			for each (var building:BuildingBase in buildings)
			{
				building.destroy();
			}
			for each (var active_weapon:activeWeapon in activeWeaponList)
			{
				active_weapon.destroy();
			}
			for each (var gameComponent:GameComponent in gameComponentList)
			{
				gameComponent.destroy();
			}
			for(var i:int=0;i<enemyList.length;i++)
			{
				enemyList[i].destroy();
			}
			while (globals.debryList.length>0)
			{
				globals.debryList.pop();
			}
			while (globals.buildings.length>0)
			{
				globals.buildings.pop();
			}
			while (globals.activeWeaponList.length>0)
			{
				globals.activeWeaponList.pop();
			}
			while (globals.activeObjectList.length>0)
			{
				globals.activeObjectList.pop();
			}
			while (globals.enemyList.length>0)
			{
				globals.enemyList.pop();
			}
			while (globals.heroList.length>0)
			{
				globals.heroList.pop();
			}
			while (gameComponentList.length>0)
			{
				gameComponentList.pop();
			}
		}

		public static function defineGameVars(gameVars:Object):void
		{
			globals.gameVars = gameVars;
		}
		public function getHeroContainer():MovieClip
		{
			if (globals.heroContainer == null)
			{
				//globals.
			}
			return globals.heroContainer;
		}
		public static function setScoreUI(score:MovieClip):void
		{
			globals.score = score;
		}
		public static function addPeople(person:MovieClip):void
		{
			if (globals.people == null)
			{
				globals.people = new Array();
			}
			globals.people.push(person);
		}
		public static function addPositiveObj(obj:MovieClip):void
		{
			if (globals.heroList == null)
			{
				globals.heroList = new Array();
			}
			globals.heroList.push(obj);
		}
		public static function addActiveObj(obj:MovieClip):void
		{
			if (activeObjectList==null)
			{
				activeObjectList = new Array();
			}
			globals.activeObjectList.push(obj);
		}
		public static function addEnemy(obj:MovieClip):void
		{
			if (enemyList==null)
			{
				enemyList= new Array();
			}
			enemyList.push(obj);
		}
		public static function setVars():void
		{
			globals.fric = .9;
		}
		public static function setMain(main:MovieClip):void
		{
			globals.main = main;
		}
		public static function setGravity(gravity:Number):void
		{
			globals.gravity = gravity;
		}
		public static function setLevel(levelObj:level):void
		{
			globals.levelObj = levelObj;
		}
		public static function setHero(hero:Hero):void
		{
			globals.hero = hero;
		}
		public static function setArmCannon(armCannon:MovieClip):void
		{
			globals.heroArm = armCannon;
			/*if (! defaultWeaponsLoaded)
			{
				defaultWeaponsLoaded = true;
				var i:int = 0;
				var j:int = 0;



				var inventory:Array = new Array();
				var wpnClass:Class;
				var wpnEnums:Vector.<String >  = WeaponsEnum.getEnum(gameVars.weaponVars.loadOut);
				var wpnInventoryEnums:Vector.<String >  = WeaponsEnum.getEnum(gameVars.weaponVars.inventory);
				for (j=0; j<wpnEnums.length; j++)
				{
					wpnClass = WeaponsEnum.getWeaponClass(wpnEnums[j]);
					if (wpnClass==MiniGun||wpnClass==LaserCannon||wpnClass==GausseCannon)
					{
						armCannon.addWeapon(new (wpnClass)(globals.hero.armCannon,globals.enemyList));
					}
					else
					{
						armCannon.addWeapon(new (wpnClass)(globals.enemyList));
					}
				}
				var loadOut:Array = WeaponList.loadOut;
				for (j=0; j<wpnInventoryEnums.length; j++)
				{
					var alreadyLoaded:Boolean = false;
					for (var k:int=0; k<wpnEnums.length; k++)
					{
						if (WeaponsEnum.getWeaponClass(wpnEnums[k]) == WeaponsEnum.getWeaponClass(wpnInventoryEnums[j]))
						{
							inventory.push(loadOut[k]);
							alreadyLoaded = true;
							break;
						}
					}
					if (! alreadyLoaded)
					{
						wpnClass = WeaponsEnum.getWeaponClass(wpnInventoryEnums[j]);
						if (wpnClass==MiniGun||wpnClass==LaserCannon||wpnClass==GausseCannon)
						{
							armCannon.addWeapon(new (wpnClass)(globals.hero.armCannon,globals.enemyList));
						}
						else
						{
							armCannon.addWeapon(new (wpnClass)(globals.enemyList));
						}
					}
				}
				//globals.hero.armCannon.weapons=inventory;
				
			}*/
		}
		public static function setSmoke(smoke:Smoke):void
		{
			globals.smoke = smoke;
		}
		public static function setSteam(steam:Steam):void
		{
			globals.steam = steam;
		}
		public static function setCam(HUD:Cam, camSpeed:int):void
		{
			globals.camSpeed = camSpeed;
			globals.HUD = HUD;
		}
	}
}