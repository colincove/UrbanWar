package {
	import com.levels.*;
	import com.globals;
	import com.UI.Prompt;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import com.interfaces.Program;
	import com.interfaces.removable;
	import com.globalFunctions;
	import com.weapons.Weapon;
	import com.camera.ScreenGrabber;
	import com.UI.GameMenuPM;
	import com.UI.OffScreen;
	import com.displayObjects.Smoke;
	import com.database.WebServices;
	import com.camera.Cam;
	import com.weapons.*;
	import com.database.User;
	import com.ProgThread;
	import flash.system.System;
	import com.controllers.GradingScaleController;

	public class gameStart
	{
		
		private var gameContinue:Boolean;
		private var camera:Cam;
		private var defaultsLoaded:Boolean=false;
		var myXML:XML;
		var myLoader:URLLoader;
		private var currentLevelObj:level;
		public var currentLevelID:int;
		public var playLevelID:int;
		public var levelsUnlocked:int;
		public var currentLevelControl:levelControl;
		private var compiler:classCompiler;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public var gameVars:Object;

		public var replayingLevel:Boolean=false;
		public function gameStart():void 
		{
			gameVars=new Object();
			globals.gameVars=defineGameVars(gameVars);
		}
		public function playSelectLevel(selectedLevel:int):void {
			playLevelID=selectedLevel;
			replayingLevel=true;
		}
		public function continueCampaign():void {
			playLevelID=currentLevelID;
			replayingLevel=false;
		}
		public function endCurrentLevel():void 
		{
			globals.hero.destroy();
			currentLevelControl.destroy();
			globals.game_progThread.endProgram();
			for (var i:int=0; i<globals.activeObjectList.length; i++)
			{
				if (globals.activeObjectList[i] is removable)
				{
					globals.activeObjectList[i].removeSelf();
				}
			}
			
			globals.resetLists();
			WeaponList.emptyLoadout();
			globals.smoke.destroy();
			globals.static_progThread.pauseProgram();
			globals.hero.removeSelf();
			if(globals.levelObj!=null)
			{
			//globals.levelObj.parent.removeChild(globals.levelObj);
			globals.levelObj.destroy();
			}
			globals.levelObj=null;
			weaponControl.clearProjectiles();
			if(currentLevelID==1)
			{
				globals.hero.jetpack=null;
				globals.hero.armCannon.clearWeapon();
				WeaponList.loadDefaultWeapons(gameVars);
			
				globals.skipWeaponMenu=true;
			}
			
			globals.main.launchWeaponMenu();
			
			System.gc();
			System.gc();
		}
		public function beatCurrentLevel():void
		{
			if (User.active) 
			{
				
				User.levelsUnlocked=currentLevelID;
				
				User.unlockedWeapons=WeaponsEnum.composeWeaponStringFromArray(WeaponList.weaponList);
				WebServices.updateUser();
				
				var prompt:Prompt=Prompt.createPrompt(globals.main,"Recording playthrough!");
				WebServices.addPlaythrough(prompt.remove,globals.points, playLevelID,WeaponsEnum.composeWeaponStringFromArray(WeaponList.loadOut),replayingLevel,ScreenGrabber.currentGrab.bitmapData,prompt.remove);
			}
			if (globals.levelProgress!==9&&replayingLevel!==true) 
			{
				globals.levelProgress++;
				currentLevelID++;
			}
			endCurrentLevel();
		}
		private function startGame():void 
		{
			globals.defineGameVars(gameVars);
			compiler = new classCompiler();
			currentLevelID=gameVars.stageStart;
			playLevelID=currentLevelID;
			globals.hero = new Hero();
			
			globals.hero.progRun=false;
			if (gameVars.forKarl) {
				startLevel();
			}
			gameContinue=true;
		}
		public function startLevel():void
		{
			globals.skipWeaponMenu=false;
System.gc();
System.gc();
globals.enemiesKilled=0;
globals.letPlayerLive=false;
			globals.static_progThread.resumeProgram();
			globals.game_progThread=new ProgThread();
			gameVars.oldOrbs=gameVars.orbs;
			if (camera==null) 
			{
				camera = new HUD();
				globals.setCam(camera, 1);//must set before starting game.
				var fps:FPS = new FPS();
			} else {
				camera.resetCAM();
			}
			buildLevel();
			var offScreen:OffScreen=new OffScreen(camera);
			//we may have alreayd loaded weapons from the server, so dont do it here again. 
			if (! defaultsLoaded&&WeaponList.weaponList.length==0) 
			{
				defaultsLoaded=true;
				WeaponList.loadDefaultWeapons(gameVars);
			}
			WeaponList.makeAllWeaponsNotNew();
			globals.main.addChild(camera);
		}
		private function buildLevel():void 
		{
			if(currentLevelID!=1 && globals.hero.getJetPack()==null){
				globals.hero.createJetpack();
			}
						 globals.key.toString = function() { return "levelKey" }
						 
			currentLevelObj=level(loadLevel("level"+playLevelID));
		
			currentLevelControl=new (loadClass("com.levels.level"+playLevelID+"Control"))(currentLevelObj);
			globals.setLevel(currentLevelObj);
			globals.setVars();
			globals.main.addChild(currentLevelObj);
			
		}
		private function loadClass(objString:String):Class {
			var classType:Class=getDefinitionByName(objString) as Class;
			return classType;
		}
		private function loadLevel(objectString:String):Object {
			var classType:Class=getDefinitionByName(objectString) as Class;
			var newObject:Object = new classType();
			return newObject;
		}
		private function defineGameVars(gameVars:Object):Object {
			var weaponsXML:XMLList = new XMLList();
			var gameXML:XMLList = new XMLList();
			var fuelXML:XMLList = new XMLList();
			var blimpXML:XMLList = new XMLList();

			var enemyXML:XMLList = new XMLList();
			myLoader = new URLLoader();
			myLoader.load(new URLRequest("GameVariables.xml"));
			myLoader.addEventListener(Event.COMPLETE, processXML);
			function processXML(e:Event):void {
				var i:int;
				trace("PROCESSING XML");
				myXML=new XML(e.target.data);
				//Game Variables
				///////////////
				////////////////
				////////////
				globals.gradingScaleController = new GradingScaleController(myXML);
				gameXML=myXML.Game;
				for (i=0; i<gameXML.*.length(); i++) {
					var tmpXMLList:XML=gameXML.*[i];
					var stageVars:Object = new Object();
					stageVars.stage=tmpXMLList.@stage;
					stageVars.screenSpeed=tmpXMLList.@screenSpeed;
					trace("STAGE STUFF", gameXML.*[i].@stage);
					gameVars['stage'+gameXML.*[i].@stage]=stageVars;
				}
				gameVars.forKarl=Boolean(gameXML.@forKarl==1);
				gameVars.outsideScreenTime=gameXML.@outsideScreenTime;
				gameVars.stageStart=gameXML.@stageStart;
				gameVars.godMode=gameXML.@godMode;
				gameVars.orbs=int(gameXML.@orbs);
				gameVars.muteSounds=gameXML.@muteSounds;
				gameVars.testingMode=gameXML.@testingMode;
				gameVars.startUpgrade=gameXML.@startUpgrade;
				gameVars.fightBoss=gameXML.@fightBoss;
				//Misc Items
				////////////////////
				//////////////////
				////////////////
				fuelXML=myXML.Fuel;
				var fuelItemVars:Object = new Object();
				fuelItemVars.addFuel=fuelXML.@addFuel;
				fuelItemVars.fallSpeed=fuelXML.@fallSpeed;
				gameVars.fuelVars=fuelItemVars;
				//
				blimpXML=myXML.Blimp;
				var blimpVars:Object = new Object();
				blimpVars.health=blimpXML.@health;
				blimpVars.speed=blimpXML.@speed;
				gameVars.blimpVars=blimpVars;
				//Weapon Variables
				////////////////////
				//////////////////
				////////////////
				weaponsXML=myXML.Weapons;
				var weaponVars:Object = new Object();
				weaponVars.loadOut=weaponsXML.@loadOut;
				weaponVars.inventory=weaponsXML.@inventory;
				weaponVars.inventoryAndUpgrades=weaponsXML.@inventoryAndUpgrades;
				for (i=0; i<weaponsXML.*.length(); i++) {
					var weaponObj:Object = new Object();
					var weaponXML:XML=weaponsXML.*[i];
					weaponObj.name=weaponXML.@name;
					weaponObj.upgrade=int(weaponXML.@upgrade);
					for (var j:int=0; j<weaponXML.*.length(); j++) {
						var upgrade:Object = new Object();
						var upgradeXML:XML=weaponXML.*[j];
						upgrade.id=upgradeXML.@id;
						upgrade.cost=upgradeXML.@cost;
						upgrade.damage=upgradeXML.@damage;
						upgrade.fireDelay=upgradeXML.@fireDelay;
						upgrade.heatUp=upgradeXML.@heatUp;
						upgrade.coolDown=upgradeXML.@coolDown;
						upgrade.coolDown=upgradeXML.@coolDown;
						upgrade.pointWorth=upgradeXML.@pointWorth;
						weaponObj['upgrade'+int(upgradeXML.@id)]=upgrade;
						///These if statements are for variables that are specific for a particular weapon. 
						if (weaponXML.@name=='ClusterLauncher') {
							upgrade.missileCount=upgradeXML.@missileCount;
						}
						if (weaponXML.@name=='ClusterLockLauncher') {
							upgrade.lockSpeed=upgradeXML.@lockSpeed;
						}
						if (weaponXML.@name=='MiniGun') {
							upgrade.stager=upgradeXML.@stager;
						}
						if (weaponXML.@name=='MissileLauncher') {
							upgrade.speed=upgradeXML.@speed;
						}
						if (weaponXML.@name=='WaveCannon') {
							upgrade.density=upgradeXML.@density;
							upgrade.degree=upgradeXML.@degree;
							upgrade.speed=upgradeXML.@speed;
						}
						if (weaponXML.@name=='LaserCannon') {
							upgrade.weight=upgradeXML.@weight;

						}
						///
					}

					//
					weaponVars[weaponXML.@name]=weaponObj;
				}
				gameVars.weaponVars=weaponVars;
				//Enemy Variables
				////////////////////
				//////////////////
				////////////////
				enemyXML=myXML.Enemies;
				var enemyVars:Object = new Object();
				for (i=0; i<enemyXML.*.length(); i++) 
				{
					var enemyObj:Object = new Object();
					var tmpEnemyXML:XML=enemyXML.*[i];
					enemyObj.name=tmpEnemyXML.@name;
					enemyObj.health=tmpEnemyXML.@health;
					enemyObj.fireDelay=tmpEnemyXML.@fireDelay;
					enemyObj.damage=tmpEnemyXML.@damage;
					enemyObj.pointWorth=tmpEnemyXML.@pointWorth;
					enemyObj.orbWorth=tmpEnemyXML.@orbWorth;
				if (enemyObj.name=='Bomber')
					{
						enemyObj.bombRadius=tmpEnemyXML.@bombRadius;
					}
					if (enemyObj.name=='Spinbot') {
						enemyObj.movePow=tmpEnemyXML.@movePow;
						enemyObj.damage=tmpEnemyXML.@gamage;
					}
					enemyVars[tmpEnemyXML.@name]=enemyObj;
				}
				gameVars.enemyVars=enemyVars;

				startGame();


			}
			return gameVars;
		}
	}
}