﻿package com.interfaces{	import flash.display.MovieClip;	import flash.geom.Point;	public interface WeaponInterface {		function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void;		function stopFiring():void;		function getIcon():MovieClip;		function getHeat():int;		function getHeatCapacity():int;		function getCoolSpeed():int;		function getHeatSpeed():int;		function setHeat(heat:int):void;		function setHeatCapacity(heatCapacity:int):void;		function setCoolSpeed(coolSpeed:int):void;		function setHeatSpeed(coolSpeed:int):void;				function setVars(wpnUpVars:Object):void;	}}