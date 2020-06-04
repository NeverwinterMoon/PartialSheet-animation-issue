# PartialSheet-animation-issue

The problem is related to [PartialSheet](https://github.com/AndreaMiotto/PartialSheet)

There is this set on the main container of `PartialSheet`:
`.animation(self.dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))`.

This applies animation to the content of the sheet provided by the library user and leads to unexpected animation appearing.

Per Apple's documentation on `animation(_:)` 
`Use this modifier on leaf views rather than container views. The animation applies to all child views within this view; calling animation(_:) on a container view can lead to unbounded scope.`

Basically, setting this on the the container (sheet view) is an anti-pattern. I think, explicit property animation should be used instead, this way no matter what the content is provided to the PartialSheet, it will not be affected. Explicit property animation would affect `.transition` to make the view slide up and down. And possibly use explicit property animation on `drag.translation.height` to have a different animation when the sheet is released after being dragged but not closed.

This project shows the problem and it looks like this:

[![Image from Gyazo](https://i.gyazo.com/4e213a97e95b7ece95396becfe5c7999.gif)](https://gyazo.com/4e213a97e95b7ece95396becfe5c7999)

As you can see from the code, the content of PartialSheet does not provide any animation details and does not want to have any animations at all, and yet it does.
