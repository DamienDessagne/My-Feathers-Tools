package controls {
	import controls.factory.LayoutFactory;
	
	import feathers.controls.ScrollContainer;
	
	
	/**
	 * A ScrollContainer with a VerticalLayout.
	 */
	public class VGroup extends ScrollContainer {
		
		// CONSTRUCTOR :
		public function VGroup() {
			super();
			layout = LayoutFactory.getVLayout();
		}
	}
}