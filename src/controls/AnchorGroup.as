package controls {
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	
	/**
	 * A ScrollContainer with an AnchorLayout, and accessible anchorLayoutData.
	 */
	public class AnchorGroup extends ScrollContainer {
		
		/** The group's layoutData. */
		public var anchorLayoutData:AnchorLayoutData;
		
		// CONSTRUCTOR :
		public function AnchorGroup() {
			super();
			layout = new AnchorLayout();
			layoutData = anchorLayoutData = new AnchorLayoutData();
		}
	}
}