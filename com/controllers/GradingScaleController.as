package com.controllers
{
	public class GradingScaleController
	{
		public var gradingTable:Vector.<GradingScale>;
		public var A:String;
		public var B:String;
		public var C:String;
		public var D:String;
		public var F:String;
		public function GradingScaleController(xml:XML)
		{
			// constructor code
			gradingTable = new Vector.<GradingScale >;
			parseGradingScales(xml);
		}
		//takes in all the level data and composes all the grading schemes. 
		private function parseGradingScales(xml:XML):void
		{
			var gameXML:XMLList = xml.Game;
			for (var i:int=0; i<gameXML.*.length(); i++)
			{
				var tmpXMLList:XML = gameXML.*[i];
				gradingTable.push(new GradingScale(tmpXMLList.GradeScale.A,
				   tmpXMLList.GradeScale.B,
				   tmpXMLList.GradeScale.C,
				   tmpXMLList.GradeScale.D,
				   tmpXMLList.GradeScale.F));
			}
			A = gameXML.GradeScaleResponse.A;
			B = gameXML.GradeScaleResponse.B;
			C = gameXML.GradeScaleResponse.C;
			D = gameXML.GradeScaleResponse.D;
			F = gameXML.GradeScaleResponse.F;
		}
		public function getStatement(points:int, level:int):String
		{
			if(level>0 && level<=9)
			{
				var gradeScale:GradingScale = gradingTable[level];
				if(points<gradeScale.F)
				{
					return F;
				}else if(points<gradeScale.D)
				{
					return D;
				}else if(points<gradeScale.C)
				{
					return C;
				}else if(points<gradeScale.B)
				{
					return B;
				}else {
					return A;
				}
			}
			return "";
		}
	}
}