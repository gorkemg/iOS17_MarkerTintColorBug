# iOS17_MarkerTintColorBug
Sample project demonstrating the issue of a MKMarkerAnnotationView ignoring markerTintColor = .clear, when it was set to a different color previously.

![Screenshot of the app with a map, which has a single annotation with an image of a bus. The annotation marker isn't visible, since it is transparent](screenshots/1._Simulator_Screenshot_-_all_correct.png "Screenshot of the app with a map, which has a single annotation with an image of a bus. The annotation marker isn't visible, since it is transparent")
![Screenshot of the app with a map, which has a single selected annotation with a blue big marker displaying the text BUS.](screenshots/2._Simulator_Screenshot_-_all_correct.png "Screenshot of the app with a map, which has a single selected annotation with a blue big marker displaying the text BUS.")
![Screenshot of the app with a map, which has a single unselected annotation. A small blue empty marker is overlayed on top of the annotation image, basically hiding it. The marker should be transparent and invisible.](screenshots/3._Simulator_Screenshot_-_not_correct.png "Screenshot of the app with a map, which has a single unselected annotation. A small blue empty marker is overlayed on top of the annotation image, basically hiding it. The marker should be transparent and invisible.")

## Issue

Up until iOS 16, it was possible to have an opaque MKMarkerAnnotationView with a markerTintColor set to a color, transition to a completely transparent marker with markerTintColor = .clear.

This was necessary if you want to only show a `markerAnnotationView.image` on the map, but the marker bubble with a glyph when the annotation was selected and vice versa (hide the marker when unselected).

However, since iOS 16 and also in iOS 17 Seed 1, this is not possible anymore.

The marker will not be transparent and overlay on top of the `markerAnnotationView.image`.

## Example
Example code inside MKMarkerAnnotationView subclass:
``` Swift
if isSelected {
    self.image = nil
    self.glyphText = "BUS"
    self.markerTintColor = .blue
}else{
    self.image = UIImage(systemName: "bus")
    self.glyphText = ""
    self.markerTintColor = .clear	// <- Issue
}
```
`self.markerTintColor = .clear` works the first time, but not a second time, leaving an empty marker on the map, hiding the `.image` below it.

## Test

- Simply open the project in Xcode (15 beta 15A5160n for iOS17 tests) and run on a Simulator or Device. You can also use a previous version of Xcode for testing with iOS 16, which has the same issue.
- Select the annotation with a bus image on the map 
	- a Marker with the Glyph "BUS" will appear
- Tap somewhere on the map to deselect the annotation, 
	- the Marker will shrink, but not disappear, leaving an empty small marker on the map, overlayed on top of the bus image, basically hiding it

## Fix

As far as I know, there is no fix, if you want to switch between opaque and transparent markers back and forth.
