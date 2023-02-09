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
		'titleElement',
		'frame'
	],
	#category : #'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #'api - building' }
LePageHeaderBuilder >> addExtensionButtons [
	^ self pageElement hasPage
		ifTrue: [ (GtPhlowActionsCollector new
				pragmaName: #lePageAction;
				fromObject: self page;
				collect)
				do: [ :each | 
					each
						asElement: [ :actionElement | self toolbarElement addItem: actionElement ]
						withHostElement: self ] ]
]

{ #category : #'private - building' }
LePageHeaderBuilder >> addFixedSeparator [
	self toolbarElement addFixedSeparator
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
LePageHeaderBuilder >> addTitle [
	self frame addChild: self titleElement.
]

{ #category : #'api - building' }
LePageHeaderBuilder >> addToolbarToFrame [
	self frame addChild: self toolbarElement
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

{ #category : #accessing }
LePageHeaderBuilder >> frame [
	^ frame
]

{ #category : #accessing }
LePageHeaderBuilder >> frame: anObject [
	frame := anObject
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
	self toolbarElement removeAllItems.
	self frame removeChildren
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
		ifNil: [ toolbarElement := LeToolbarElement new hFitContent padding: (BlInsets top: 10) ]
]

{ #category : #'api - accessing' }
LePageHeaderBuilder >> toolbarElement: anObject [
	toolbarElement := anObject
]
