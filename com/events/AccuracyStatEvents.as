package  com.events{
	import flash.events.Event;
	
	public class AccuracyStatEvents extends Event
	{
public static const STATS_UPDATED:String="statsUpdated";
		public function AccuracyStatEvents(type:String,bubbles:Boolean=false,cancelable:Boolean=false) 
		{
			super(type, bubbles,cancelable);
			// constructor code
		}

	}
	
}
