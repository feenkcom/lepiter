Class {
	#name : #LeFileSelectStencil,
	#superclass : #BrStencil,
	#instVars : [
		'label',
		'tooltip',
		'extent',
		'selectionElement',
		'visitor',
		'textEditorPiece',
		'subText'
	],
	#category : #'Lepiter-UI-Snippet-Text actions'
}

{ #category : #'api - instantiation' }
LeFileSelectStencil >> create [
	"Create the new element"

	| aButton |
	"Specify the button to be used when the dropdown is hidden"
	aButton := BrButton new.
	aButton
		aptitude:
			(BrGlamorousLinkSquaredButtonWithLabelAndIconAptitude new);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets all: 3);
		margin:
			(BlInsets
				top: -1
				left: 3
				bottom: 0
				right: 3) + textEditorPiece wordMargin;
		beSmallSize;
		icon: BrGlamorousIcons loadfromdisk;
		label: label;
		addAptitude:
			(BrGlamorousWithExplicitDropdownAptitude
				handle: [ BrButton new
						icon: BrGlamorousIcons loadfromdisk;
						label: label;
						beSmallSize;
						aptitude: (BrGlamorousLinkSquaredButtonWithLabelAndIconAptitude new)
					"- BrGlamorousButtonWithLabelTooltipLook
						- BrGlamorousButtonExteriorLook" ]
				content: [ | stencil |
					stencil := LeImportFileSelector new.
					stencil
						folder: FileLocator home;
						okAction: [ :file :button | 
							file isFile
								ifTrue: [ button fireEvent: BrDropdownHideWish new.
									self importFromFile: file type: stencil currentType ] ];
						buttonLabel: 'Import';
						exact: self extent;
						padding: (BlInsets all: 20) ]).	"+ textEditorPiece wordPadding"
	^ aButton
]

{ #category : #private }
LeFileSelectStencil >> database [ 
	"Answer the LeDatabase of the receiver's snippet"

	^ visitor styler database
]

{ #category : #accessing }
LeFileSelectStencil >> extent [
	^ extent
]

{ #category : #accessing }
LeFileSelectStencil >> extent: anObject [
	extent := anObject
]

{ #category : #private }
LeFileSelectStencil >> importFromFile: file type: importType [
	"If required, copy or move the file to the receiver's database, and then update the link to point to it"
	| attachedFile attachedUrl subTextSize |

	attachedFile := importType = #copy ifTrue:
		[ self database addAttachmentByCopy: file ]
	ifFalse: [ importType = #move ifTrue:
		[ self database addAttachmentByMove: file ]
	ifFalse: [ importType = #inplace ifTrue:
		[ file asAbsolute fullName ]
	ifFalse: [ self error: 'Unknown import type' ] ] ].
	"Convert the attachedFile to a file URL relative to the database"

	attachedUrl := attachedFile asFileReference asZnRelativeUrl.
	"update the snippet to link to the new attachment"
	subTextSize := subText size.
	"Check that nothing's changed"
	self assert: visitor text = self snippet text.
	self assert: (subText copyFrom: subTextSize-1 to: subTextSize) = '()'.
	self snippet insertText: attachedUrl asRopedText at: subTextSize + subText start - 2 source: nil.
	"If the label is empty, use the file basename"
	(subText copyFrom: 1 to: 2) = '[]' ifTrue: 
		[ self snippet insertText: file basename asRopedText at: subText start source: nil ].
]

{ #category : #initialization }
LeFileSelectStencil >> initialize [
	super initialize.
	tooltip := 'Import File'.
	extent := 600 @ 400.

]

{ #category : #accessing }
LeFileSelectStencil >> label [
	^ label
]

{ #category : #accessing }
LeFileSelectStencil >> label: anObject [
	label := anObject
]

{ #category : #accessing }
LeFileSelectStencil >> selectionElement [
	^ selectionElement
]

{ #category : #accessing }
LeFileSelectStencil >> selectionElement: anObject [
	selectionElement := anObject
]

{ #category : #private }
LeFileSelectStencil >> snippet [ 
	"Answer the LeSnippet of the receiver's snippet"

	^ visitor styler snippet
]

{ #category : #accessing }
LeFileSelectStencil >> subText [
	^ subText
]

{ #category : #accessing }
LeFileSelectStencil >> subText: anObject [
	subText := anObject
]

{ #category : #accessing }
LeFileSelectStencil >> textEditorPiece [
	^ textEditorPiece
]

{ #category : #accessing }
LeFileSelectStencil >> textEditorPiece: anObject [
	textEditorPiece := anObject
]

{ #category : #accessing }
LeFileSelectStencil >> tooltip [
	^ tooltip
]

{ #category : #accessing }
LeFileSelectStencil >> tooltip: anObject [
	tooltip := anObject
]

{ #category : #accessing }
LeFileSelectStencil >> visitor [
	^ visitor
]

{ #category : #accessing }
LeFileSelectStencil >> visitor: anObject [
	visitor := anObject
]

{ #category : #'announcer - subscription' }
LeFileSelectStencil >> when: anAnnouncementClass do: aValuable [

	selectionElement when: anAnnouncementClass do: aValuable
]
