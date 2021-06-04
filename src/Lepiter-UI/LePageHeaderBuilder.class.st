"
I am an abstract class.
I am used by {{gtClass:LePageToolContentElement}}.
My subclasses build {{gtClass:LePageToolContentElement}}'s {{gtClass:LeToolbarElement|label=toolbar}} items.
See my {{gtClass:LePageHeaderBuilder|expanded|show=#gtSubclassesFor:}} for concrete implementations:


"
Class {
	#name : #LePageHeaderBuilder,
	#superclass : #Object,
	#instVars : [
		'pageElement',
		'toolbarElement',
		'titleElement'
	],
	#category : #'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #'api - building' }
LePageHeaderBuilder >> addExtensionButtons [
	^ (Pragma
		allNamed: #leHeaderAction
		from: self class
		to: ProtoObject)
			do: [ :eachPragma | 
				self perform: eachPragma methodSelector ]. 
]

{ #category : #'private - building' }
LePageHeaderBuilder >> addFixedSeparator [
	self toolbarElement addFixedSeparator
]

{ #category : #'private - building' }
LePageHeaderBuilder >> addFlexibleSeparator [
	self toolbarElement addFlexibleSeparator
]

{ #category : #'private - building' }
LePageHeaderBuilder >> addInspectButton [
	| anInspectButton |
	anInspectButton := BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'Inspect';
		icon: BrGlamorousVectorIcons inspect;
		action: [ :aButton | aButton phlow spawnTool: self page asLepiterPagePhlowTool ].
	anInspectButton userData at: #isInspectButton put: true.
	self toolbarElement addItem: anInspectButton.
]

{ #category : #'private - building' }
LePageHeaderBuilder >> addRemoteLinkToClipboardButton [
	"Add a button the copies the markdown to reference the receiver as a remote page"
	| newButton |

	newButton := BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'Copy as Remote Reference to the clipboard';
		icon: BrGlamorousVectorIcons clipboard;
		action: [ :aButton | Clipboard clipboardText: self page asRemoteLink ].
	self toolbarElement addItem: newButton.
]

{ #category : #'private - building' }
LePageHeaderBuilder >> addRemovePageButton [
	| aButton |
	aButton := BrButton new.
	aButton
		aptitude: BrGlamorousButtonWithIconAptitude
			+ (BrGlamorousWithDropdownAptitude
					handle: [ BrButton new
						icon: BrGlamorousIcons empty;
						aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude ]
					content: (LePageRemoveDropdownContentStencil new
						pageElement: self pageElement;
						anchor: aButton));
		label: 'Remove Page';
		icon: BrGlamorousVectorIcons remove.
	self toolbarElement addItem: aButton.
]

{ #category : #'private - building' }
LePageHeaderBuilder >> addTableOfContentsToggle [
	| aToggle |
	aToggle := BrToggle new.
	aToggle
		aptitude: BrGlamorousToggleWithIconAptitude;
		label: 'Promote page as Table of Contents';
		icon: BrGlamorousIcons tree;
		addEventHandler: (LeTableOfContentsToggleEventHandler new 
			pageElement: self pageElement);
		addAptitude: (BrToggleAptitude new
			activated: [ :aState | aState do: [ :aWidget | 
				aWidget label: 'Withdraw page as Table of Contents' ] ];
			deactivated: [ :aState | aState do: [ :aWidget | 
				aWidget label: 'Promote page as Table of Contents' ] ]).
	
	self toolbarElement addItem: aToggle.
]

{ #category : #'private - building' }
LePageHeaderBuilder >> addTitle [
	self toolbarElement addItem: self titleElement.
]

{ #category : #'api - building' }
LePageHeaderBuilder >> build [
	"Build toolbar items"
	self subclassResponsibility
]

{ #category : #'api - accessing' }
LePageHeaderBuilder >> database [
	<return: #LeDatabase>
	^ self pageElement database
]

{ #category : #'api - accessing' }
LePageHeaderBuilder >> page [
	<return: #LePage>
	^ self pageElement pageViewModel pageModel
]

{ #category : #'api - accessing' }
LePageHeaderBuilder >> pageElement [

	^ pageElement
]

{ #category : #'api - accessing' }
LePageHeaderBuilder >> pageElement: anObject [
	pageElement := anObject
]

{ #category : #'private - building' }
LePageHeaderBuilder >> removeAllItems [
	self toolbarElement removeAllItems
]

{ #category : #'api - accessing' }
LePageHeaderBuilder >> titleElement [
	^ titleElement
]

{ #category : #'api - accessing' }
LePageHeaderBuilder >> titleElement: anObject [
	titleElement := anObject
]

{ #category : #'api - accessing' }
LePageHeaderBuilder >> toolbarElement [
	<return: #LeToolbarElement>
	^ toolbarElement
]

{ #category : #'api - accessing' }
LePageHeaderBuilder >> toolbarElement: anObject [
	toolbarElement := anObject
]
