package 
{
	import flash.display.MovieClip;
	import com.globals;
	import com.weapons.*;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import com.Sound.GlobalSounds;
	import com.weapons.MissileLauncher;
	import com.interfaces.WeaponInterface;
	import flash.geom.Point;
	import com.Sound.GlobalSounds;
	import flash.events.MouseEvent;
	import com.UI.WeaponUI;
	import com.globalFunctions;
	import flash.geom.ColorTransform;
	import com.displayObjects.activeObj;
	import flash.events.KeyboardEvent;
	public class weaponControl extends activeObj
	{
		public var weapons:Array;
		private var ratio:Number = 0;
		private var weaponOverheat:Boolean;
		private var soundChannel:SoundChannel;
		private var soundTrans:SoundTransform;
		private var steam:MovieClip;
		protected var barrelPoint:Point;//point at which bullets origonate from
		public var loadOut:Array;
		private var interval:int;
		public var selectedWeapon:Weapon;
		public var weaponNum:int = 0;
		public static var heroProjectileList:Vector.<activeWeapon >  = new Vector.<activeWeapon >   ;
		private var weaponUI:MovieClip;
		public function weaponControl():void
		{
			weaponUI = new WeaponUI(this);
			steam=new steamObj();
			interval = 0;
			steam.visible = false;
			soundChannel = GlobalSounds.playSound('steam',9999);
			soundTrans=new SoundTransform();


			globals.addPositiveObj(this);

		}
		protected function shoot(origin:Point):void
		{
			if(!Hero.disableHero){
			if (! globals.game_progThread.isPaused)
			{
				if (! selectedWeapon)
				{
					if (WeaponList.loadOut.length > 0)
					{
						weaponNum = 0;
						changeWeapon();
					}
				}
				else
				{

					if (! selectedWeapon.isOverheated() && ! selectedWeapon.isShooting())
					{
						//globals.hero.armCannon.artwork.gotoAndPlay('shoot');
						WeaponInterface(selectedWeapon).fire(this.rotation,origin, globals.enemyContainer);
						globals.hero.armCannon.artwork.gotoAndPlay("shoot");
					}
					else
					{
						GlobalSounds.playSound('weaponHot');
					}
				}
			}
			}
		}
		public override function hit(xPos:int, yPos:int, strength:int=20):void
		{
			globals.hero.hit(globalFunctions.getLevelX(globals.hero), globalFunctions.getLevelY(globals.hero), strength);
		}
		protected function stopShoot():void
		{
			if(!Hero.disableHero){
			if (selectedWeapon!=null)
			{
				if (! selectedWeapon.isOverheated())
				{
					globals.hero.armCannon.artwork.gotoAndPlay('stopShoot');
					WeaponInterface(selectedWeapon).stopFiring();
				}
			}
			}
		}
		public function addLoadoutWeapon(weapon:Weapon, reload:Boolean=false)
		{


			weaponNum = 0;

			if (WeaponList.loadOut.length < 3)
			{
				weaponNum = WeaponList.loadOut.length - 1;
				changeWeapon();

			}
			if (selectedWeapon==null)
			{
				weaponNum = 0;

			}
		}
		public function addWeapon(weapon:Weapon, reload:Boolean=false):void
		{

		}

		private function prevWeapon():void
		{
			
			if (weaponNum!=0)
			{
				weaponNum--;
				changeWeapon();
			}
			
		}
		private function nextWeapon():void
		{

			if (weaponNum!=WeaponList.loadOut.length-1)
			{
				weaponNum++;
				changeWeapon();
			}
		}
		protected function changeWeapon():void
		{
			stopShoot();
			if (weaponNum<WeaponList.loadOut.length)
			{
				selectedWeapon = WeaponList.loadOut[weaponNum];
				globals.hero.armCannon.gotoAndStop(selectedWeapon.getName());
				globals.hero.armCannon.artwork.gotoAndPlay(1);
			}
		}
		protected function scrollUp(e:MouseEvent):void
		{
			if(!Hero.disableHero){
			if (e.delta > 0)
			{
				nextWeapon();
			}
			else
			{
				prevWeapon();
			}
			}
			
		}
		public function getWeaponList():Array
		{
			return WeaponList.weaponList;
		}
		public function getLoadOut():Array
		{
			return loadOut;
		}
		protected function checkWeaponSwitch(e:KeyboardEvent):void
		{
			if(!Hero.disableHero){
			var Code = e.keyCode - 48;
			if (Code>-1&&Code<10&&Code<=WeaponList.loadOut.length)
			{
				if(weaponNum!=Code - 1){
				weaponNum = Code - 1;
				changeWeapon();
				}
				
			}
			else
			{
				if (e.keyCode == 69)
				{
					nextWeapon();
				}
				if (e.keyCode == 81)
				{
					prevWeapon();
				}
			}
			}
		}
		protected function makeSteam(ratio:Number):void
		{
			if (steam.parent != globals.neutralContainer && steam.parent != null)
			{

				steam.parent.removeChild(steam);
			}
			if (steam.parent != null)
			{
				if (ratio>.5)
				{
					soundTrans.volume = (ratio - .5) / .5;
				}
				else
				{
					soundTrans.volume = 0;
				}
				steam.scaleX = ratio * 2;
				steam.scaleY = ratio * 2;
				steam.gotoAndStop(Math.round(ratio*100));
				ratio = 30 - (ratio * 30);
				steam.x = globals.hero.x + 5;
				steam.y = globals.hero.y - 40;
				if (selectedWeapon.isOverheated())
				{
					steam.gotoAndStop(99);
					soundTrans.volume = 1;
					globals.smoke.steamBM.drawObject(steam);
					steam.scaleX = 1.5;
					steam.scaleY = 1.5;
					if (! weaponOverheat)
					{
						for (var i:int=0; i<10; i++)
						{
							steam.x=globals.hero.x+5+(Math.random()-Math.random())*60;
							steam.y=globals.hero.y-40+(Math.random()-Math.random())*60;
							globals.smoke.steamBM.drawObject(steam);
						}
						weaponOverheat = true;
					}
				}
				else
				{
					weaponOverheat = false;
					if (selectedWeapon.getHeat() != 0)
					{
						if (interval>ratio)
						{
							globals.smoke.steamBM.drawObject(steam);
							interval = 5;
						}
						else
						{
							interval++;
						}
					}
				}
				soundChannel.soundTransform = soundTrans;
			}
			else
			{
				if (globals.neutralContainer != null)
				{
					globals.neutralContainer.addChild(steam);
				}

			}
		}
		public static function addHeroProjectile(weapon:activeWeapon):void
		{
			heroProjectileList.push(weapon);
		}
		public static function removeHeroProjectile(weapon:activeWeapon):void
		{
			var index:int = heroProjectileList.indexOf(weapon);
			if (index!=-1)
			{
				heroProjectileList.splice(index, 1);
			}
		}
		public static function containsProjectile(weapon:activeWeapon):Boolean
		{
			var index:int = heroProjectileList.indexOf(weapon);
			if (index==-1)
			{
				return false;
			}
			return true;
		}
		public static function clearProjectiles()
		{
			heroProjectileList.splice(0,heroProjectileList.length);


		}
		public function clearWeapon():void
		{
			selectedWeapon=null;
			globals.hero.armCannon.gotoAndStop(1);
		}
	}
}