﻿package com.items{	import flash.display.MovieClip;	import com.globalFunctions;	import com.globals;	import com.interfaces.Program;	import flash.events.Event;	import com.weapons.Weapon;	import com.Sound.GlobalSounds;	public class FuelItem extends FallingItem implements Program {		private var radius:int;		private var actionClip:MovieClip;		private var distance:int;		private var fuelAmt:int;		protected var attackList:String;		public function FuelItem():void		{			super(60,this);			fuelAmt=globals.gameVars.fuelVars.addFuel;			this.attackList=attackList;			globals.game_progThread.addProg(this);			progRun=true;		}		public function action():void		{			globals.hero.addFuel(fuelAmt);			removeSelf();			parent.removeChild(this);					globals.game_progThread.removeProg(this);		}	}}