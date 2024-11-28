Extension { #name : #GtPhlowSpaceBuilder }

{ #category : #'*Lepiter-UI' }
GtPhlowSpaceBuilder >> pageInPager: aLePage [
	"A lepiter page phlow tool is either:
	- spawned to the next GtPager pane, or
	- displayed as a new GtWorld tab, or
	- opened in a new window."

	self
		title: aLePage title;
		icon: LeIcons lepiterPage;
		inPager: [ aLePage asLepiterPagePhlowTool asElementDo: [ :e | e ] ] asStencil.
]

{ #category : #'*Lepiter-UI' }
GtPhlowSpaceBuilder >> spawnPage: aLePage [
	"A lepiter page phlow tool is either:
	- spawned to the next GtPager pane, or
	- displayed as a new GtWorld tab, or
	- opened in a new window."

	<return: #BlSpace or: nil>
	self pageInPager: aLePage.

	self fromElement ifNil: [ ^ self show ].
	^ self spawnTool: [ aLePage asPhlowTool ]
]
