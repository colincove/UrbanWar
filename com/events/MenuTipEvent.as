package com.events {
	import flash.events.Event;
public class MenuTipEvent extends Event{
	public static const CANCEL:String="cancel";
	public static const COLOR_RED:String="red";
	public static const COLOR_WHITE:String="white";
	public static const TIP:String="tip";
	public var tipText:String="";
	public var color:String="";
	public function MenuTipEvent(type:String,tipText:String="",color:String=COLOR_WHITE , bubbles:Boolean=false, cancelable:Boolean=false):void {
		super(type, bubbles, cancelable);
		this.tipText=tipText;
		this.color=color;
	}
}
}