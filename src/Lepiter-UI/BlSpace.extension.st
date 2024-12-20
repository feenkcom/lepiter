Extension { #name : #BlSpace }

{ #category : #'*Lepiter-UI' }
BlSpace >> pageInPager: aLePage [
	"A lepiter page phlow tool is either:
	- spawned to the next GtPager pane, or
	- displayed as a new GtWorld tab, or
	- opened in a new window."

	self
		title: aLePage printPageTabLabel;
		icon: LeIcons lepiterPage;
		inPager: [ aLePage asLepiterPagePhlowTool asElementDo: [ :e | e ] ] asStencil.
]

{ #category : #'*Lepiter-UI' }
BlSpace class >> spawnPage: aLePage from: anElement [
	"A page phlow tool is either:
	- spawned to the next GtPager pane, or
	- displayed as a new GtWorld tab, or
	- opened in a new window."

	<return: #BlSpace or: nil>
	| aSpaceOrNil |
	self 
		assert: [ aLePage isNotNil ] 
		description: [ 'Page must be non-nil' ].
	aSpaceOrNil := self
			spawnTool: [ aLePage asLepiterPagePhlowTool ]
			from: anElement.
	aSpaceOrNil ifNotNil: [ :aSpace | 
		aSpace 
			title: aLePage printPageTabLabel;
			icon: LeIcons lepiterPage ].
			
	^ aSpaceOrNil
]
