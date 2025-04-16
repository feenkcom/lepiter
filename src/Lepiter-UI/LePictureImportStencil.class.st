Class {
	#name : #LePictureImportStencil,
	#superclass : #BrStencil,
	#instVars : [
		'tooltip',
		'extent',
		'pictureElement'
	],
	#category : #'Lepiter-UI-Basic - Support'
}

{ #category : #'api - instantiation' }
LePictureImportStencil >> create [
	"Create the new element"

	| aButton |
	"Specify the button to be used when the dropdown is hidden"
	aButton := BrButton new.
	aButton
		icon: BrGlamorousIcons loadfromdisk;
		label: self tooltip;
		aptitude: BrGlamorousButtonWithIconAptitude;
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
				handle: [ BrButton new
						icon: BrGlamorousIcons folder;
						label: self tooltip;
						aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2
								- BrGlamorousButtonExteriorAptitude ]
				content: [ | stencil element |
					stencil := LeImportFileSelector new.
					stencil
						folder: FileLocator home;
						okAction: [ :file :button | 
							file isFile
								ifTrue: [ aButton dispatchEvent: (BrDropdownHideWish new anchor: aButton).
									self importFromFile: file type: stencil currentType ] ];
						buttonLabel: 'Import';
						exact: self extent;
						padding: (BlInsets all: 20).
					element := stencil asElement.
					element addAptitude: BrGlamorousPopoverResizableAptitude new.
					element ]).
	^ aButton
]

{ #category : #'api - accessing' }
LePictureImportStencil >> database [

	^ pictureElement database
]

{ #category : #accessing }
LePictureImportStencil >> extent [
	^ extent
]

{ #category : #accessing }
LePictureImportStencil >> extent: anObject [
	extent := anObject
]

{ #category : #importing }
LePictureImportStencil >> importFromFile: aFile type: importType [ 
	"If required, copy or move the file to the receiver's database, and then update the URL to point to it"
	| attachedFile |

	pictureElement ifNil: [ ^ self ].

	attachedFile := importType = #copy ifTrue:
		[ self database addAttachmentByCopy: aFile ]
	ifFalse: [ importType = #move ifTrue:
		[ self database addAttachmentByMove: aFile ]
	ifFalse: [ importType = #inplace ifTrue:
		[ aFile asAbsolute fullName ]
	ifFalse: [ self error: 'Unknown import type' ] ] ].

	pictureElement pictureUrlString: attachedFile.
]

{ #category : #initialization }
LePictureImportStencil >> initialize [
	super initialize.
	tooltip := 'Select Picture'.
	extent := 400 @ 300
]

{ #category : #accessing }
LePictureImportStencil >> pictureElement [
	^ pictureElement
]

{ #category : #accessing }
LePictureImportStencil >> pictureElement: anObject [
	pictureElement := anObject
]

{ #category : #accessing }
LePictureImportStencil >> tooltip [
	^ tooltip
]

{ #category : #accessing }
LePictureImportStencil >> tooltip: anObject [
	tooltip := anObject
]
