package com.controllers
{
	
	public class GradingScale 
	{

private var _A:int;
private var _B:int;
private var _C:int;
private var _D:int;
private var _F:int;
		public function GradingScale(A:int, B:int, C:int, D:int, F:int)
		{
			// constructor code
			_A=A;
			_B=B;
			_C=C;
			_D=D;
			_F=F;
		}
		public function get A():int
		{
			return _A;
		}
		public function get B():int{
			return _B;
		}
		public function get C():int{
			return _C;
		}
		public function get D():int{
			return _D;
		}
		public function get F():int{
			return _F;
		}

	}
	
}
