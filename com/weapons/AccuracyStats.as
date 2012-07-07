package com.weapons {
	import com.events.AccuracyStatEvents;
	import flash.events.EventDispatcher;
	
	public class AccuracyStats  extends EventDispatcher
	{
public static var hit:int=0;
public static var miss:int=0;
public static var total:int=0;
public static var pct:Number=100.0;
public static var currentStatsObj:AccuracyStats
		public function AccuracyStats() 
		{
			AccuracyStats.currentStatsObj=this;
			// constructor code
		}
		public static function addMiss():void
		{
			miss++;
			total++;
			calcPct();
		}
		public static function addHit():void
		{
			hit++;
			total++;
			calcPct();
		}
		public static function calcPct():void
		{
			if(currentStatsObj!=null)
			{
				currentStatsObj.dispatchEvent(new AccuracyStatEvents(AccuracyStatEvents.STATS_UPDATED));
			}
			pct=hit/total*100;
		}
		public static function resetFunctions():void
		{
			hit=0;
			miss=0;
			total=0;
			pct=0;
			currentStatsObj.dispatchEvent(new AccuracyStatEvents(AccuracyStatEvents.STATS_UPDATED));
		}

	}
	
}
