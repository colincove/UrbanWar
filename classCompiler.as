package {
	//this class contains several object of classes that i need to dynamically load with getDefinitionByName. 
	//the problem was that in order to use that method, i needed to have some kind of reference to the class somewhere else already
	//so this is a useless class, just used to compile 'dynamic' classes, instead of messing up my important classes. 
	//http://nwebb.co.uk/blog/?p=186
	import com.levels.*;
	public class classCompiler {
		private var comp1:level1Control;
		private var comp2:level2Control;
		private var comp3:level3Control;
		private var comp4:level4Control;
		private var comp5:level5Control;
		private var comp6:level6Control;
		private var comp7:level7Control;
		private var comp8:level8Control;
		private var comp9:level9Control;
		public function classCompiler():void {
		}
	}
}