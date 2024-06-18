Class {
	#name : #LeWardleyMapNodeToPageLinkElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapNodeViewModel + TBrLayoutResizable + TLeWithSnippetModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait + TBrLayoutResizable classTrait + TLeWithSnippetModel classTrait',
	#instVars : [
		'linkButton',
		'linkEditor',
		'linkEditorCompletionStrategy'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Helpers - Context Menu'
}

{ #category : #initialization }
LeWardleyMapNodeToPageLinkElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #initialization }
LeWardleyMapNodeToPageLinkElement >> initialize [
	super initialize.

	self initializeLinkEditor.
	self initializeLinkButton.
	
	self addChild: linkEditor.
	self addChild: linkButton.
	
	self
		vFitContent;
		hFitContentLimited;
		margin: GtWardleyMapUtility menuItemMarginInsets.
]

{ #category : #initialization }
LeWardleyMapNodeToPageLinkElement >> initializeLinkButton [
	linkButton := GtWardleyMapUtility newMenuItemButtonWithIcon
			icon: BrGlamorousVectorIcons inspect;
			label: 'Go to page'
]

{ #category : #initialization }
LeWardleyMapNodeToPageLinkElement >> initializeLinkEditor [
	| completionController |
	linkEditor := BrEditableLabel new
			aptitude: BrGlamorousEditableLabelAptitude new 
				glamorousRegularFontAndSize;
			text: '';
			hExact: GtWardleyMapConstants menuItemEditorWidth;
			vFitContent.

	linkEditorCompletionStrategy := LeCompletionStrategy new.

	completionController := GtCompletionController
			on: linkEditor
			strategy: linkEditorCompletionStrategy.
	completionController install.

	linkEditor
		when: BrEditorAcceptWish
		do: [ :aWish | self onEditorAcceptWish: aWish ].

	^ linkEditor
]

{ #category : #'event handling' }
LeWardleyMapNodeToPageLinkElement >> onDatabaseChanged [
	self hasSnippetModel ifFalse: [ ^ self ].

	linkEditorCompletionStrategy database: self snippetModel database
]

{ #category : #'event handling' }
LeWardleyMapNodeToPageLinkElement >> onEditorAcceptWish: aWish [
	| aNewPageName |
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	self hasSnippetModel ifFalse: [ ^ self ].

	aNewPageName := aWish text asString trimBoth
			trimBoth: [ :ch | 
				{$[.
					$]} includes: ch ].
	
	self wardleyMapNodeViewModel
				detectDecorator: [ :each | 
					each isLinkToAnyLepiterPage ]
				ifFound: [ :aDecorator | 
					self wardleyMapNodeViewModel removeWardleyMapDecoratorModel: aDecorator ]
				ifNone: [ ].

	self snippetModel
		createLinkFromNode: self wardleyMapNodeViewModel wardleyMapNodeModel
		toPageNamed: aNewPageName.
		
	self snippetModel
		updateWardleyMapDecoratorsFor: self wardleyMapNodeViewModel wardleyMapNodeModel.
		
	self onLinkNodeChanged
]

{ #category : #'event handling' }
LeWardleyMapNodeToPageLinkElement >> onLinkNodeChanged [
	linkButton action: [  ].
	linkButton visibility: BlVisibility gone.
	
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	self hasSnippetModel ifFalse: [ ^ self ].

	self snippetModel
		linkForNode: self wardleyMapNodeViewModel wardleyMapNodeModel
		ifFound: [ :aLink |
			"for now we assume that the target is page. but it should not be like that"
			linkEditor text: aLink targetReference content title.

			linkButton action: [ :aButtonElement | 
				self phlow spawnTool: (
					aLink targetReference content asPhlowTool) ].
			linkButton visibility: BlVisibility visible ]
]

{ #category : #'api - snippet model' }
LeWardleyMapNodeToPageLinkElement >> onSnippetModelChanged [
	"Is sent when a new snippetModel is assigned to the receiver.
	Note: #onSnippetModelChanged is sent before #subscribeToSnippetModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSnippetModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self onDatabaseChanged.
	self onLinkNodeChanged
]

{ #category : #'api - wardley map node view model' }
LeWardleyMapNodeToPageLinkElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self onLinkNodeChanged
]
