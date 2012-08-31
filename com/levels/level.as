package com.levels{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import com.globals;
	import com.interfaces.Program;
	import com.interfaces.removable;
	import com.globalFunctions;
	import com.displayObjects.Smoke;
	import com.displayObjects.Steam;
	import Controls;
	import flash.events.KeyboardEvent;
	import com.UI.PausePrompt;
	import com.GameComponent;

	public class level extends GameComponent implements Program
	{
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		private var ID:int;//For level 1, ID would be 1.  For level 2, the ID would be 2. etc. 
		private var pPress:Boolean;
		private var BGController1:BG_BitmapController;
		private var BGController2:BG_BitmapController;
		private var beginningPoints:int;
private var overlayLayer:MovieClip;

		public function level(ID:int=0):void
		{
			this.ID=ID;
			//
			//
			if(globals.overlayLayer.parent!=null)
			{
				globals.overlayLayer.parent.removeChild(globals.overlayLayer);
				this.addChild(globals.overlayLayer);
			   }
			overlayLayer = globals.overlayLayer;
	
			this.addChild(overlayLayer);
			overlayLayer.x=this.hero_container.x;
			overlayLayer.y=this.hero_container.y;
			globals.heroContainer=this.hero_container;
			globals.enemyContainer=this.ground_enemy_container;
			globals.neutralContainer=this.neutral_contrainer;
			globals.groundContainer=this.ground_enemy_container["ground_container"];
			globals.emptyGround=new MovieClip();
			globals.setSmoke(new Smoke(this.neutral_contrainer));
			globals.trails=new MovieClip();
			beginningPoints=globals.gameVars.orbs;
			this.addChild(globals.trails);
			addChild(globals.emptyGround);
			globals.game_progThread.addProg(this);
			progRun=true;
			globals.main.stage.addEventListener(KeyboardEvent.KEY_DOWN,pauseCheck,false, 0, true);
			globals.main.stage.addEventListener(KeyboardEvent.KEY_UP,pauseUnCheck,false, 0, true);
			globals.levelObj=this;
			build();
		}                                                                                                                                                                                                                           
		private function buildLevel():void
		{
		}
		public function build() {
			//this.removeChild(this.BG1);
			//this.removeChild(this.BG2);
			this.BG1.visible=false;
			this.BG2.visible=false;
			var BG1_BM:Bitmap=new Bitmap(new BitmapData(1600,1000,true,0x88ff0000));
			var BG2_BM:Bitmap=new Bitmap(new BitmapData(1600,1000,true,0x88ff0000));

			this.addChild(BG2_BM);
			this.addChild(BG1_BM);
			this.swapChildren(BG1_BM,BG1);
			this.swapChildren(BG2_BM,BG2);
			BGController1=new BG_BitmapController(BG1_BM,BG1);
			BGController2=new BG_BitmapController(BG2_BM,BG2,8);

		}
		public function isRunning():Boolean {
			return progRun;
		}
		private function pauseUnCheck(e:KeyboardEvent):void {
			pPress=false;
		}
		private var pausePrompt:PausePrompt;
		private function pauseCheck(e:KeyboardEvent):void {
			if (e.keyCode==80) {
				if (! pPress) {
					if (! globals.gamePause) 
					{
						globals.game_progThread.pauseProgram();
						globals.static_progThread.pauseProgram();
						globals.gamePause=true;
						pausePrompt=PausePrompt.createPrompt(globals.main, pausePromptCallback);
						//globals.main.launchPauseMenu();
					} else {
						if(pausePrompt!=null)
						{
							pausePrompt.remove();
							pausePrompt=null;
						}
						globals.game_progThread.resumeProgram();
						globals.static_progThread.resumeProgram();
						globals.gamePause=false;
						//globals.main.removePauseMenu();
					}
				}
				pPress=true;
			}
		}
		private function pausePromptCallback():void{
			globals.game_progThread.resumeProgram();
						globals.static_progThread.resumeProgram();
						globals.gamePause=false;
		}
		public function update():Object 
		{
			globals.neutralContainer.graphics.clear();

			this.BG1.x=this.x-globals.HUD.x/2;
			this.BG2.x=this.x-globals.HUD.x/6;
			this.BG1.y=this.y-globals.HUD.y/2;
			this.BG2.y=this.y-globals.HUD.y/15;
			BGController1.update();
			BGController2.update();

			if (this.endGame.hitTestPoint(globalFunctions.getMainX(globals.hero),globalFunctions.getMainY(globals.hero),true)) 
			{
				globals.main.getGame().beatCurrentLevel();

			}
			return this;
		}
		public override function destroy():void
		{
			super.destroy();
			overlayLayer=null;
			
			this.BGController1.destroy();
			this.BGController2.destroy();
			if(BG1.parent!=null){
			BG1.parent.removeChild(BG1);
			}
			if(BG2.parent!=null){
			BG2.parent.removeChild(BG2);
			}
			globals.heroContainer=null;
			globals.enemyContainer=null;
			globals.neutralContainer=null;
			globals.groundContainer=null;
			progRun=false;
			globals.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN,pauseCheck,false);
			globals.main.stage.removeEventListener(KeyboardEvent.KEY_UP,pauseUnCheck,false);
		}
		public function removeSelf():void
		{
			
		}
		private function checkBackground(bm:Bitmap, sourceBG:MovieClip, aid:String):void {



		}

	}
}
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.filters.BitmapFilterQuality;
import flash.filters.BlurFilter;
import flash.display.MovieClip;
import com.globals;
import flash.geom.Rectangle;
import com.globalFunctions;
internal class BG_BitmapController {
	private var BM:Bitmap;
	private var BG:MovieClip;
	private var rect:Rectangle;
	private var newPt:Point;
	private var oldPt:Point;
	private var offset:Point;
	private var centre:Point;
	private var ptSize:int=200;
	private var blurFilter:BlurFilter;
	public function BG_BitmapController(BM:Bitmap,BG:MovieClip, z:int=4):void {
		this.BM=BM;
		this.BG=BG;
		centre=new Point(BM.width/2,BM.height/2);
		centre.x-=50;
		blurFilter = new BlurFilter(z,z,BitmapFilterQuality.LOW);
		rect=new Rectangle(0,0,BM.width,BM.height);
		this.newPt=new Point(BG.x,BG.y);
		offset=new Point(int((globals.HUD.x-globalFunctions.getMainX(BM))/ptSize),int((globals.HUD.y-globalFunctions.getMainY(BM))/ptSize));
		this.oldPt=new Point(BG.x,BG.y);
	}
	public function destroy():void
	{
		
		
		BM.bitmapData.dispose();
		BG=null;
		rect=null;
		newPt=null;
		oldPt=null;
		offset=null;
		centre=null;
		blurFilter=null;
	}
	public function update():void 
	{
		newPt.x=int((globals.HUD.x-globalFunctions.getMainX(BM))/ptSize);
		newPt.y=int((globals.HUD.y-globalFunctions.getMainY(BM))/ptSize);
		var xMod:int=newPt.x-oldPt.x;
		var yMod:int=newPt.y-oldPt.y;
		oldPt.x=int((globals.HUD.x-globalFunctions.getMainX(BM))/ptSize);
		oldPt.y=int((globals.HUD.y-globalFunctions.getMainY(BM))/ptSize);
		BM.x=BG.x+offset.x*ptSize-centre.x;
		BM.y=BG.y+offset.y*ptSize-centre.y;
		if (xMod!=0||yMod!=0) 
		{
			offset.x=int((globals.HUD.x-globalFunctions.getMainX(BG))/ptSize);
			offset.y=int((globals.HUD.y-globalFunctions.getMainY(BG))/ptSize);
			BM.x=BG.x+offset.x*ptSize-centre.x;
		BM.y=BG.y+offset.y*ptSize-centre.y;
			var matrix:Matrix = new Matrix(1,0,0,1,(BG.x-BM.x),(BG.y-BM.y));
			BM.bitmapData.fillRect(BM.bitmapData.rect,0);
			BM.bitmapData.draw(BG,matrix);
BM.bitmapData.applyFilter(BM.bitmapData,rect,new Point(0,0),blurFilter);

		}
	}

}