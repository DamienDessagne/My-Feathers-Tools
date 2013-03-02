package {
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.themes.MetalWorksMobileTheme;
	
	import screens.HomeScreen;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * Simply add a Feathers theme and shows the samples screen.
	 */
	public class Samples extends Sprite {
		
		// SCREEN IDs :
		/** The HomeScreen. */
		public static const HOME_SCREEN:String = "Screens.HomeScreen";
		
		
		/** Feathers theme. */
		private var theme:MetalWorksMobileTheme;
		
		/** The ScreenNavigator. */
		public static var nav:ScreenNavigator;
		
		
		
		// CONSTRUCTOR :
		public function Samples() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * Creates every element and shows the HomeScreen.
		 */
		private function init(ev:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Init the theme :
			theme = new MetalWorksMobileTheme(this.stage);
			
			// Create the navigator :
			nav = new ScreenNavigator();
			nav.addScreen(HOME_SCREEN, new ScreenNavigatorItem(HomeScreen));
			addChild(nav);
			
			// Show the HomeScreen :
			nav.showScreen(HOME_SCREEN);
			
			trace("Started !");
		}
	}
}