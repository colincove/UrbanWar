package com.weapons{
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.globalFunctions;
	import com.weapons.activeWeapon;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.interfaces.activeWeaponInterface;
	import com.interfaces.Program;
	import com.weapons.WaveParticle;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Wave extends activeWeapon implements activeWeaponInterface,Program {
		private var density:int;
		private var degree:int;
		private var leaveInterval:int=0;
		private var particleArray:Array;
		private var tmpParticleArray:Array;
		public var waveAlpha:Number=0.01;
		public function Wave(Angle:int, originPoint:Point,primaryHitCheck:MovieClip,attackList:Array, strength:int=20, density:int=20,degree:int=20, pointWorth:int=0, speed:int=10):void {
			super(originPoint,primaryHitCheck, strength, null, pointWorth);
			this.attackList=attackList;
			ground=primaryHitCheck;
			this.density=density;
			this.degree=degree;
			rotation=Angle;
			this.Speed=speed;
			globals.game_progThread.addProg(this);
			progRun=true;
			globals.game_progThread.resumeProgram();
			//particleArray = new Array();
			//tmpParticleArray=makeWave(originPoint,degree,density);
			tmpParticleArray = new Array();
			particleArray =makeWave(originPoint,degree,density);
		}
		public function getAllParticles():Array
		{
			var output:Array = new Array();
			var i:int;
			for(i=0;i<particleArray.length;i++){
				output.push(particleArray[i]);
			}
			for(i=0;i<tmpParticleArray.length;i++){
				output.push(tmpParticleArray[i]);
			}
			return output;
		}
		public override function destroy():void
		{
			super.destroy();
			if(particleArray!=null)
			{
			particleArray.splice(0);
			
			}
			particleArray=null;
		}
		private function makeWave(originPoint:Point, degree:int, density:int):Array
		{
			var tmpArray:Array = new Array();
			var tmpAngle:int;
			leaveInterval++;
			for (var i:int=0; i<density; i++) 
			{
				tmpAngle=rotation-degree/2+i*degree/density;
				var waveParticle:WaveParticle=new WaveParticle(tmpAngle,originPoint,primaryHitCheck,attackList, this,strength,tmpArray,i, pointWorth, Speed);
				tmpArray.push(waveParticle);
			}
			return tmpArray;
		}
		public function update():Object 
		{
			
			var started:Boolean;
			var i:int;
			var j:int;
			var tmpWaveShape:Array;
			var waveShapes:Array = new Array();
			waveAlpha=waveAlpha*2;
			if(waveAlpha>1.0)
			{
				waveAlpha=1.0;
			}
			for (i=0; i<particleArray.length; i++)
			{
				if (particleArray[i]!=null) 
				{
					var particle:WaveParticle = particleArray[i];
					if(particle!=null){
					if (started) 
					{
						particle.styleLine(globals.trails);
						tmpWaveShape.push(particle);
						//globals.trails.graphics.lineTo(particleArray[i].x, particleArray[i].y);
					} else {
						tmpWaveShape=new Array();
						tmpWaveShape.push(particle);
						waveShapes.push(tmpWaveShape);
						//globals.trails.graphics.moveTo(particleArray[i].x, particleArray[i].y);
						started=true;
					}
					particle.update();
					}
				} else {
					started=false;
				}
			}
			for (i=0; i<waveShapes.length; i++) 
			{
				globals.trails.graphics.beginFill(0xFFFFFF,waveAlpha);
				globals.trails.graphics.lineStyle(1,0xFFFFFF,waveAlpha);
				var shape:Array=waveShapes[i];
				globals.trails.graphics.moveTo(shape[0].x, shape[0].y);
				for (j=1; j<shape.length; j++)
				{
					globals.trails.graphics.lineTo(shape[j].x, shape[j].y);
				}

				for (j=shape.length-1; j>=0; j--)
				{
					//var xComp:int=Math.cos((shape[j].Angle+180)*(Math.PI/180))*(shape[j].Speed+10);
					////var yComp:int=Math.sin((shape[j].Angle+180)*(Math.PI/180))*(shape[j].Speed+10);
					var xComp:int=Math.cos((shape[j].Angle+180)*(Math.PI/180))*(shape[j].Speed*2+10);
					var yComp:int=Math.sin((shape[j].Angle+180)*(Math.PI/180))*(shape[j].Speed*2+10);
					globals.trails.graphics.lineTo(shape[j].x+xComp, shape[j].y+yComp);
				}
				globals.trails.graphics.endFill();
			}
			globals.trails.graphics.lineStyle(1,0xFFFFFF,1);
			if(tmpParticleArray.length!=0)
			{
				particleArray.push(tmpParticleArray.splice(Math.floor(tmpParticleArray.length/2),1)[0]);
				
				particleArray.sortOn(["key"]);
			}
			return this;
		}
		public function impact():void
		{
			if(leaveInterval>5)
			{
			GlobalSounds.playSound('explosion1');
			checkObjDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			removeSelf();
			}
		}
		public function removeSelf():void 
		{
			destroy();
			globals.game_progThread.removeProg(this);
			parent.removeChild(this);
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		public function makeHeroWave()
		{
			var i:int;
			for ( i=0; i<particleArray.length; i++)
			{
				weaponControl.addHeroProjectile(particleArray[i]);
			}
			for (i=0; i<tmpParticleArray.length; i++)
			{
				weaponControl.addHeroProjectile(tmpParticleArray[i]);
			}
			
			
		}
	}
}