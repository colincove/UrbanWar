package com.enemies
{
	import com.enemies.Bomber;
	import com.globals;
	public class BomberReverse extends Bomber
	{
		public function BomberReverse():void
		{
			super();
			Speed = Speed * -1;
		}
		public override function update():Object
		{
			super.update();
		if (! isOnScreen())
			{
				
				if (x>globals.hero.x && xSpeed>0)
				{
					this.removeEnemy(false);
					removeActiveObj();
					globals.game_progThread.removeProg(this);
					if (parent!=null) {
				parent.removeChild(this);
			}
				}
			}

			return null;
		}

	}
}