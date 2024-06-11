Class {
	#name : #LeWardleyMapNodeEditorElement,
	#superclass : #GtWardleyMapNodeEditorElement,
	#instVars : [
		'snippet',
		'linkEditor',
		'linkEditorCompletionStrategy',
		'linkButton',
		'canvasElement'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Helpers'
}

{ #category : #accessing }
LeWardleyMapNodeEditorElement >> canvasElement [
	^ canvasElement
]

{ #category : #accessing }
LeWardleyMapNodeEditorElement >> canvasElement: anObject [
	canvasElement := anObject
]

{ #category : #initialization }
LeWardleyMapNodeEditorElement >> createNodeLinkButton [	
	linkButton := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		beSmallSize;
		label: 'go to page'.
		
	^ linkButton
]

{ #category : #initialization }
LeWardleyMapNodeEditorElement >> createNodeLinkEditor [
	| completionController |
	linkEditor := BrEditableLabel new
			aptitude: BrGlamorousEditableLabelAptitude new;
			text: '';
			hExact: 100;
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

{ #category : #initialization }
LeWardleyMapNodeEditorElement >> createNodeLinkLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
		margin: (BlInsets top: 5 left: 5 bottom: 2 right: 0);
		text: 'Link node to:'
]

{ #category : #initialization }
LeWardleyMapNodeEditorElement >> createPropertyEditorElements [
	^ super createPropertyEditorElements, { 
		self createNodeLinkLabel.
		
		BrHorizontalPane new
			cellSpacing: 5;
			vFitContent;
			hFitContentLimited;
			margin: (BlInsets top: 5 left: 0 bottom: 2 right: 0);
			alignCenterLeft;
			addChildren: {
				self createNodeLinkEditor.
				self createNodeLinkButton	
			}
	}
]

{ #category : #'event handling' }
LeWardleyMapNodeEditorElement >> onEditorAcceptWish: aWish [
	| aNewPageName |
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

	self snippet
		createLinkFromNode: self wardleyMapNodeViewModel wardleyMapNodeModel
		toPageNamed: aNewPageName.
		
	self snippet
		updateWardleyMapLepiterPageLinksFor: self wardleyMapNodeViewModel wardleyMapNodeModel.
		
	^ self updateLinks
]

{ #category : #accessing }
LeWardleyMapNodeEditorElement >> snippet [
	^ snippet
]

{ #category : #accessing }
LeWardleyMapNodeEditorElement >> snippet: aLeWardleySnippet [
	snippet := aLeWardleySnippet.
	linkEditorCompletionStrategy database: aLeWardleySnippet database.

	self updateLinks
]

{ #category : #private }
LeWardleyMapNodeEditorElement >> updateLinks [
	linkButton action: [  ].
	linkButton visibility: BlVisibility gone.

	self snippet
		linkForNode: self wardleyMapNodeViewModel wardleyMapNodeModel
		ifFound: [ :aLink |
			"temporary, for now we assume that the target is page. but it should not be like that"
			linkEditor text: aLink targetReference content title.

			linkButton action: [ :aButtonElement | self canvasElement phlow spawnTool: (aLink targetReference content asPhlowTool) ].
			linkButton visibility: BlVisibility visible ]
]
