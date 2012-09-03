package com.weapons{
		import com.interfaces.jetPackInterface;
		import com.interfaces.Program;
		import com.globals;
	public class LimitedJetPack extends jetPack implements Program {
		public var pct:Number;
		
		private var total:Number;
		private var current:Number=0;
		private var coolDownInterval:int=0;
				public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function LimitedJetPack(user:jetPackInterface, fuel:int=500):void {
			super(user, fuel);
			total=fuel;
			progRun=true;
						globals.static_progThread.addProg(this);

		}
		public override function jetPackIgnite(silent:Boolean=true):void
		{
			
			if(current<total)
			{
				coolDownInterval=0;
				super.jetPackIgnite(silent);
				current++;
			}
			
		}
		public override function destroy():void{
			super.destroy();
		}
		public function update():Object
		{
		if(++coolDownInterval>20)
			{
				if(current>0)
				{
					current--;
				}
			}
			pct=current/total;
			return this;
		}
		public function isRunning():Boolean 
	{
			return progRun;
		}
	}
}