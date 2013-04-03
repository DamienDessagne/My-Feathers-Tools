package controls {
	import controls.factory.LayoutFactory;
	
	import feathers.controls.ScrollContainer;
	
	import starling.display.DisplayObject;
	
	
	
	/**
	 * A ScrollContainer with an HorizontalLayout.
	 */
	public class HGroup extends ScrollContainer {
		
		// CONSTRUCTOR :
		public function HGroup() {
			super();
			layout = LayoutFactory.getHLayout();
		}
	}
}