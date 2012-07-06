package 
{
	import com.interfaces.pausable;
	import com.interfaces.jetPackInterface;
	import com.interfaces.dieable;
	import com.interfaces.Program;
	import com.physics.*;
	import com.myMath.hitTestLine;
	import com.Sound.GlobalSounds;
	import com.interfaces.removable;
	import flash.events.Event;
	import flash.display.MovieClip;
	import com.globals;
	import com.items.Shield;
	import com.weapons.Weapon;
	import com.weapons.jetPack;
	import com.globalFunctions;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Hero extends objMovement implements pausable,jetPackInterface,dieable,removable,Program
	{
		private var keyStrokes:Controls;
		private var jumpHeight:int;
		private var currentSprite:String;
		private var walking:Boolean;
		private var idle:Boolean;
		public var jetpack:jetPack;
		public var armCannon:arm;
		public var shield:Shield;
		public var jet:Boolean;
		private var fire:MovieClip;
		public var weaponInventory:Array;

		private var empTimer:Timer;
		public function Hero():void
		{
			super();
			globals.gameComponentList.splice(globals.gameComponentList.indexOf(this),1);
			jumpHeight = 23;
			//
			fire= new Fire();
			healthBarObj.modPos(0,-100);
			health = 500;
			healthTot = health;
			globals.addPositiveObj(this);
			Speed = 1.4;
			ySpeed = 0;
			headRoom = 50;
			
			walking = false;
			idle = false;
			globals.setHero(this);
			radius = 10;
			speedMax = 7;
			empTimer = new Timer(10000);
			globals.static_progThread.addProg(this);
			armCannon = new arm(this);
			this.armContainer.addChild(armCannon);
			keyStrokes = new Controls(this);
			addEventListener(Event.ADDED_TO_STAGE, loadSelf, false, 0, true);
		}
		public function addShield(shield:Shield):void
		{
			if(this.shield!=null)
			{
				this.shield.removeSelf();
			}
			this.shield = shield;
		}
		public function removeShield():void
		{
			this.shield = null;
		}
		public function getWeaponList():Array
		{
			return armCannon.getWeaponList();
		}
		public override function hit(xPos:int, yPos:int, strength:int=20):void
		{
			var randomNum:int;
			if (shield==null)
			{

				globals.HUD.shakeFunction(strength);
				this.animation.shake(strength);
				randomNum = Math.ceil(Math.random() * 2);
				GlobalSounds.playSound('HeroHit'.concat((String)(randomNum)));
				//GlobalSounds.playSound('HeroHit');
				super.hit(xPos,yPos,strength);
			}
			else
			{
				randomNum = Math.ceil(Math.random() * 2);
				GlobalSounds.playSound('ShieldHit'.concat((String)(randomNum)));
				//GlobalSounds.playSound('ShieldHit'.concat((String)((int)(Math.ceil(Math.random()*2)))));
				shield.hit(xPos, yPos, strength);
			}
		}
public override function destroy():void
{
	removeSelf();
}
		public function getLoadOut():Array
		{
			return armCannon.getLoadOut();
		}
		public function removeSelf():void
		{

			//jetpack.removeSelf();
			//jetpack = null;S
			//keyStrokes.removeSelf();
			//armCannon.removeSelf();
			//jetpack = null;
			//keyStrokes.removeSelf();
			if(parent!=null){
				parent.removeChild(this);
			}
			armCannon.progRun = false;
			ground=null;
			progRun = false;
			armCannon.removeSelf();
			xSpeed = 0;
			ySpeed = 0;
			progRun = false;
			visible = false;
			
		}
		public function addWeapon(weapon:Weapon, reload:Boolean=false):void
		{
			armCannon.addWeapon(weapon, reload);
		}
		private function reloadSelf():void
		{

		}
		private function loadSelf(e:Event):void
		{
			globals.setArmCannon(armCannon);
			ground = globals.groundContainer;
			armCannon.resumeArmFunction();
			healthBarObj.initialize(this);
			if(animation.parent==null)
			{
				this.addChild(animation);
			}
//trace("Loading hero", animation, animation.parent);
			progRun = true;
			if (parent!=null)
			{
				parent.addChild(fire);
			}
			fire.visible = false;
			for (var i:int=0; i<WeaponList.weaponList.length; i++)
			{
				WeaponList.weaponList[i].reloadWeapon();
			}
			visible =true;
		}
		//removeEventListener(Event.ADDED_TO_STAGE, loadSelf, false);

		public function update():Object
		{
			animation.scaleX = dir;
			if (jet)
			{
				if (jetpack!=null)
				{
					if (! Controls.upArrowPress)
					{
						jet = false;
					}
					jetpack.jetPackIgnite(false);
					bottemFlame.visible = true;
				}
				//globals.smoke.fireDownBM.drawObject(fire);
			}
			else
			{
				bottemFlame.visible = false;
			}

			if (right)
			{
				modifySpeedX(Speed);
			}
			if (left)
			{
				modifySpeedX(-Speed);
			}
			movementUpdate();
			moveObj();
			checkScreen();
			if (! haveAir)
			{
				jet = false;
				
				if (! walking)
				{
					if (right||left)
					{
						walking = true;
						animation.gotoAndStop('run');
					}
					else
					{
						if (! idle)
						{
							if ((xSpeed>2)||(xSpeed<(2*-1)))
							{
								animation.gotoAndStop('stop');
							}
							else
							{
								GlobalSounds.playSound('land');
								animation.gotoAndStop('land');
							}
							idle = true;
						}
					}
				}else{
					if(dir==-1 && animation.currentLabel!="runStart")
					{
						//animation.scaleX=dir;
						//animation.gotoAndStop("runStart");
					}
					if(dir==1&& animation.currentLabel!="runStart")
					{
						//animation.scaleX=dir;
						//animation.gotoAndStop("runStart");
					}
				}
				backFlame.visible = false;
				frontFlame.visible = false;
				bottemFlame.visible = false;
			}
			else
			{
				fire.x = x;
				fire.y = y - 50;
				//if (jet) {
					if(jetpack!=null){
						
					
				if (jetpack.active)
				{
					if (right)
					{
						//globals.smoke.fireRightBM.drawObject(fire);
						backFlame.visible = true;
					}
					else
					{
						backFlame.visible = false;
					}
					if (left)
					{
						//globals.smoke.fireLeftBM.drawObject(fire);
						frontFlame.visible = true;
					}
					else
					{
						frontFlame.visible = false;
						//}
					}
				}
				else
				{
					frontFlame.visible = false;
					backFlame.visible = false;
					bottemFlame.visible = false;
				}
				}
				if(animation.currentLabel=="runStart" ||animation.currentLabel=="idle")
				{
					walking=false;
					animation.gotoAndStop("jump");
				}
				if (walking)
				{
					animation.gotoAndStop('fall');
					walking = false;
				}
				
				roof();
				idle = false;
			}
			if (health<=0&&globals.gameVars.godMode!=1)
			{
				die();
			}
			checkSecondaryHit();
			return this;
		}
		private function checkSecondaryHit()
		{

			if (ground.hitTestPoint(globalFunctions.getMainX(this),globalFunctions.getMainY(this) + ySpeed + 1 - headRoom,true))
			{
				if (haveAir)
				{
					y +=  hitTestLine.getLine(globalFunctions.getMainX(this),globalFunctions.getMainY(this) - headRoom,ground,20,5,true,0,1);
					ySpeed = 0;
				}
			}
		}
		public function die():void
		{
			health = 0;
			globals.main.heroDie();
shield=null;

			animation.gotoAndStop('die');

			//if root is null, then I am not on the main stage and creating debry will fail. 
			if (this.root != null)
			{
				globalFunctions.makeDebry("enemyDebry",6,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			}
			removeSelf();
		}

		private function roof():void
		{
			var camDist:int = globalFunctions.getMainY(this) - globalFunctions.getMainY(globals.HUD);
			if (camDist<150)
			{
				//y+=150-camDist; this was breaking the game somehow. 
			}
		}
		public function pauseSelf():void
		{
		}
		public function unpauseSelf():void
		{
		}
		public function upPress():void
		{
			if (! haveAir)
			{
				idle = false;
				animation.gotoAndStop('jump');
				ySpeed =  -  jumpHeight;

			}
			else
			{
				jet = true;
				if(jetpack!=null)
				{
				if (jetpack.active)
				{
					if (ySpeed>0)
					{
						ySpeed = 0;
					}
				}
				}
			}
		}
		public function downPress():void
		{
		}
		public function rightHold():void
		{
		}
		public function leftHold():void
		{
		}
		public function rightPress():void
		{
			right = true;
			startWalk();
			if(!left){
			dir = 1;
			}
		}
		private function startWalk():void
		{
			idle = false;
			if (! haveAir && ySpeed==0)
			{
				animation.gotoAndStop('runStart');
			}
		}
		private function stopWalk():void
		{
			if (walking)
			{
				animation.gotoAndStop('stop');
			}
		}
		public function leftPress():void
		{
			left = true;
			startWalk();
			if(!right){
			dir = -1;
			}
		}
		public function rightUp():void
		{
			
			if(left){
				dir=-1;
			}else{
				stopWalk();
			}
			right = false;
		}
		public function leftUp():void
		{
			
			if(right){
				dir=1;
			}else{
				stopWalk();
			}
			left = false;
		}
		public function noFuel():void
		{
		}
		public function addFuel(amt:int):void
		{
			jetpack.addFuel(amt);
		}

		public function getJetPack():jetPack
		{
			return jetpack;
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		public function resetHero()
		{
			armCannon.progRun = true;
			progRun = false;
			health = this.healthTot;
			animation.gotoAndStop(1);
			visible = true;
			progRun = true;

		}
		public function createJetpack():void{
			if(jetpack==null)
			{
				jetpack = new jetPack(this);
			}
		}
		public function EMP():void
		{
			if(jetpack!=null){
			jetpack.active = false;
			}
			empTimer.addEventListener(TimerEvent.TIMER, empComplete);
			empTimer.start();
		}
		private function empComplete(e:TimerEvent):void
		{
			if(jetpack!=null){
			jetpack.active = true;
			}
			empTimer.reset();
			empTimer.removeEventListener(TimerEvent.TIMER, empComplete);
		}
	}
}