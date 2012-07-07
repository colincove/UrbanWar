package com.items{
	import flash.display.MovieClip;
	import com.globals;
	import com.globalFunctions;
	import com.Sound.GlobalSounds;
	import com.interfaces.Program;
	import com.myMath.myAngle;
	import com.GameComponent;
	public class Shield extends GameComponent implements Program {
		private var power:int;
		private var totalPower:int;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
private var hitArray:Array;
private var shieldMask:MovieClip;
private var radius:int;
private var hitContainer:MovieClip;
		public function Shield(power:int=100):void 
		{
			this.power=power;
			y=-40;
			shieldMask=new ShieldMask();
			this.addChild(shieldMask);
			shieldMask.visible=false;
			
			globals.hero.addChild(this);
			totalPower=power;
			globals.game_progThread.addProg(this);
			progRun=true;
			radius=this.width/2;
			populateHitArray();
		}
		public override function destroy():void
		{
			super.destroy();
			hitArray.slice(0);
			hitArray=null;
			shieldMask=null;
			hitContainer=null;
		}
		private function populateHitArray():void {
			hitArray = new Array();
			hitContainer=new MovieClip();
			for(var i:int=0;i<10;i++){
				hitArray[i]=new ShieldHit(); 
				hitArray[i].mask=shieldMask;
				hitArray[i].alpha=0;
				hitContainer.addChild(hitArray[i]);
			}
			hitContainer.mask=shieldMask;
			this.addChild(hitContainer);
		}
		public function getTotal():int {
			return totalPower;
		}
		public function getPower():int {
			return power;
		}
		public function getRatio():Number {
			return getPower()/getTotal();
		}
		public function hit(xPos:int, yPos:int, strength:int):void {
			power-=strength;
					for(var i:int=0;i<hitArray.length;i++){
				if(hitArray[i].alpha==0){
					var a:int=myAngle.getAngle(globalFunctions.getMainX(this), xPos, globalFunctions.getMainY(this), yPos);
					hitArray[i].x=Math.cos(a*(Math.PI/180))*radius;
					hitArray[i].y=Math.sin(a*(Math.PI/180))*radius;
					hitArray[i].alpha=1;
					break;
				}
			}
			if(power<=0){
				removeSelf();
			}
		}
		public function update():Object
		{
			updateHitArray();
			return this;
		}
		private function updateHitArray():void {
			for(var i:int=0;i<hitArray.length;i++){
				if(hitArray[i].alpha>0){
					hitArray[i].alpha-=.05;
				}else{
					hitArray[i].alpha=0;
				}
			}
		}
		public function removeSelf():void {
			if(hitArray!=null){
				
			
			for(var i:int=0;i<hitArray.length;i++){
				hitArray[i].parent.removeChild(hitArray[i]);
			}
			hitArray.splice(0);
			}
			if(parent!=null){
			parent.removeChild(this);
			}
			globals.game_progThread.removeProg(this);
			globals.hero.removeShield();
			
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
}