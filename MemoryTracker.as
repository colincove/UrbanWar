package 
{
    import flash.display.Stage;
    import flash.events.Event;
    import flash.net.LocalConnection;
    import flash.system.System;
    import flash.text.TextField;
    import flash.utils.Dictionary;
    import flash.utils.setTimeout;
     
    /**
     * A tool for tracking objects in memory and seeing if they've been properly 
     * deleted. The layout is described in 
     * http://www.craftymind.com/2008/04/09/kick-starting-the-garbage-collector-in-actionscript-3-with-air/
     * @author Damian Connolly
     */
    public class MemoryTracker
    {
         
        /***********************************************************/
         
        private static var m_tracking:Dictionary = new Dictionary( true ); // the dictionary that we use to track everyone
        private static var m_count:int      = 0;            // we garbage collect over a few frames, so this keeps track of the frames
        private static var m_stage:Stage    = null;         // a reference to the stage - we need this for the frame listener
        private static var m_debug:TextField    = null;         // the debug textfield that we'll write to
         
        /***********************************************************/
         
        /**
         * [write-only] A reference to the stage
         */
        public static function set stage( s:Stage ):void
        {
            MemoryTracker.m_stage = s;
        }
         
        /**
         * [write-only] Set a debug TextField to log into
         */
        public static function set debugTextField( t:TextField ):void
        {
            MemoryTracker.m_debug = t;
        }
         
        /***********************************************************/
         
        /**
         * Tracks an object
         * @param obj   The object that we're tracking
         * @param label The label we want to associate with this
         */
        public static function track( obj:*, label:String ):void
        {
            MemoryTracker.m_tracking[obj] = label;
        }
         
        /**
         * Start garbage collection and check for any references that remain. This 
         * will only work in the debug player or AIR app (as it's the only place we 
         * can call System.gc()). This will work over a number of frames
         */
        public static function gcAndCheck():void
        {
			
            // this can only work if we have the stage reference
            if ( MemoryTracker.m_stage == null )
            {
                MemoryTracker._log( "Please set the Stage reference in MemoryTracker.stage before calling this" );
                return;
            }
             
            // reset our count and start our enter frame listener
            MemoryTracker.m_count = 0;
            MemoryTracker.m_stage.addEventListener( Event.ENTER_FRAME, MemoryTracker._gc );
        }
         
        /***********************************************************/
         
        // Perform a garbage collect. We call it a number of times as the first time 
        // is for the mark phase, while the second call performs the sweep
        private static function _gc( e:Event ):void
        {
            // should we run the last collection?
            var runLast:Boolean = false;
             
           /* CONFIG::release
            {
                // dirty hack way of calling the garbage collector, so I'm
                // only running it on release mode
                try {
                    new LocalConnection().connect( "foo" );
                    new LocalConnection().connect( "foo" );
                } catch ( e:Error ) { }
                 
                // just go direct to the last
                runLast = true;
            }*/
             
           // CONFIG::debug
            //{
                System.gc();
                 
                // we run the last one if our count is right
                runLast = MemoryTracker.m_count++ > 1;
           // }
             
            // should we stop the event listener and run the last gc?
            // In debug mode, we call System.gc() a total of 4 times: 3 in this 
            // function, and one final time in _doLastGC()
            if ( runLast )
            {
                // use e.target in the rare chance that MemoryTracker.stage has 
                // been cleared in the meantime
                ( e.target as Stage ).removeEventListener( Event.ENTER_FRAME, MemoryTracker._gc );
                setTimeout( MemoryTracker._doLastGC, 40 );
            }
        }
         
        // Performs the last garbage collect. This is from the link at the top: 
        // "Lastly, not all features in AIR could be unhooked with our enterFrame 
        // trick, after another couple days of testing we found components that 
        // needed to be unhooked with Timers like the HTML component."
        private static function _doLastGC():void
        {
            //CONFIG::debug
           // {
                // only call this in debug mode
                System.gc();
           // }
             
            // trace out the remaining objects in our dictionary
            MemoryTracker._log( "-------------------------------------------------" );
            MemoryTracker._log( "Remaining references in the MemoryTracker:" );
            for ( var key:Object in MemoryTracker.m_tracking )
                MemoryTracker._log( "  Found reference to " + key + ", label:'" + MemoryTracker.m_tracking[key] + "'" );
            MemoryTracker._log( "-------------------------------------------------" );
        }
         
        // traces out a message and logs it to our debug TextField if we have one
        private static function _log( msg:String ):void
        {
          //  trace( msg , "");
            if ( MemoryTracker.m_debug != null )
                MemoryTracker.m_debug.appendText( msg + "\n" );
        }
         
    }
 
}