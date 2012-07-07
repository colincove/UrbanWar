package com.displayObjects{
	import flash.events.Event;
	import com.globals;
	import com.physics.shakeObj;
	import com.UI.healthBar;
	import com.interfaces.neutralObj;
	import com.interfaces.populated;
	import com.displayObjects.Artwork;
	import flash.display.MovieClip;
	import com.globalFunctions;

	//import com.worldObjects.person;
	import com.worldObjects.Civilian;
	import com.GameComponent;
	public class activeObj extends GameComponent {
		private var _health:int;
		public static var DIE:String="die";
		protected var spawned:Boolean;
		protected var onScreen:Boolean;
		protected var spawnScreen:Boolean;//is true when the spawn point is on screen;
		public var healthTot:int;
		public var pointWorth:int=0;
		protected var healthBarObj:healthBar;
		private var art:Array;
		private var personSpawnNum:int;
		private var personSpawnAmt:int;
		protected var modifyHealthX:int;
		protected var modifyHealthY:int;
		public function activeObj():void {
			health=100;
			personSpawnAmt=20;
			personSpawnNum=0;
			//if(MovieClip(this).healthDefine!=null){
			//}
			healthTot=health;
			
				healthBarObj=new healthBar(this);
			
			
			//addChild(healthBarObj);
			if (!(this is neutralObj)) {
				globals.addActiveObj(this);
			}
			addEventListener(Event.REMOVED_FROM_STAGE,removedFromStage);
		}
		public override function destroy():void
		{
			super.destroy();
			removeActiveObj();
			//DIE=null;
			if (healthBarObj!=null)
			{
				healthBarObj.destroy();
			}
			healthBarObj=null;
			if (art!=null) {
				for (var i:int=0; i<art.length; i++)
				{
					art[i].destroy();
				}
				art.slice(0);
			}
			art=null;
			removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStage);
		}
		public function checkStatus():void {
		}
		public function isDead():Boolean {
			return health>=0;
		}
		public function get health():int {
			return _health;
		}
		public function set health(value:int):void {
			_health=value;

		}
		public function hit(xPos:int, yPos:int, strength:int=20):void {

			if (health>0) {
				health-=strength;
				personSpawnNum+=strength;
				healthBarObj.activateBar();
				if (this is populated&&parent!=null&&personSpawnNum>personSpawnAmt)
				{
					/*for (var j:int =1; j<personSpawnNum/personSpawnAmt; j++)
					{
					var p:Civilian = new Civilian();
					globals.enemyContainer.addChild(p);
					p.x=globalFunctioans.makeX(p,globalFunctions.getMainX(this));
					p.y=globalFunctions.makeY(p,globalFunctions.getMainY(this));
					}
					personSpawnNum=0;*/
				}
				if (art!=null) {
					if (art[0]!=null) {
						for (var i:int =0; i<art.length; i++) {
							if (art[i].hitTestPoint(xPos,yPos,true)) {
								art[i].shake(strength);

								break;
							}
						}
					}
				}
			}
		}
		public function getHealth():int {
			return health;
		}
		public function getHealthTot():int {
			return healthTot;
		}
		public function addArtwork(artIn:shakeObj):void {
			if (art==null) {
				art = new Array();
			}
			art.push(artIn);
		}
		protected function removeActiveObj():void
		{

			if (!(this is neutralObj))
			{

				globalFunctions.removeFromList(globals.activeObjectList,this);

			}
		}
		private function removedFromStage(e:Event):void 
		{
			
			this.dispatchEvent(new Event(DIE));
			
			removeEventListener(Event.REMOVED_FROM_STAGE,removedFromStage);
		}
	}
}