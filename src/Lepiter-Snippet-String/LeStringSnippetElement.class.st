Class {
	#name : #LeStringSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'contentElement',
		'toolbarElement',
		'stringEditor',
		'bindingEditor'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #initialization }
LeStringSnippetElement >> go [
	| string bindingName sharedBindings binding |
	string := stringEditor text asString.
	bindingName := bindingEditor text asString.
	sharedBindings := self snippetViewModel snippetBindings.
	binding := sharedBindings bindingOf: bindingName asSymbol.
	binding value: string.
	^ bindingName -> string
]

{ #category : #initialization }
LeStringSnippetElement >> initialize [
	| indicatorElement playButton playInspectButton |
	
	super initialize.
	
	stringEditor := BrEditor new.
	stringEditor aptitude: BrGlamorousCodeEditorAptitude.
	stringEditor editor text: String loremIpsum asRopedText.
	
	"editorElement
		constraintsDo: [ :c | 
			c frame horizontal alignLeft.
			c frame vertical alignTop ].
	editorElement hMatchParent."
	
	stringEditor size: 640@240.
	
	indicatorElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularSmallSize
		foreground: BrGlamorousColors textMarkupColor);
		margin: (BlInsets top: 5 right: 5);
		text: 'String Resource'.
	indicatorElement constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop ].

	contentElement := BrFrame new
		hMatchParent;
		vFitContent;
		addChildren: { stringEditor. indicatorElement }.
		
	toolbarElement := BrToolbar new
		aptitude: BrGlamorousToolbarAptitude;
		hMatchParent;
		vFitContent.
		
	playButton := BrButton new
		beTinySize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons play;
		label: 'Set string';
		action: [ :aButton | self go ].
		
	toolbarElement addItem: playButton.
	
	playInspectButton := BrButton new
		beTinySize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons playinspect;
		label: 'Set string and inspect';
		action: [ :aButton | aButton phlow spawnObject: self go ].
		
	toolbarElement addItem: playInspectButton.
	
	toolbarElement addItem: (BrLabel new
		beTinySize;
		text: 'Binding:' asRopedText;
		aptitude: BrGlamorousLabelAptitude new).
	
	bindingEditor := BrEditor new.
	bindingEditor vFitContent.
	bindingEditor hMatchParent.
	bindingEditor aptitude: (BrGlamorousEditableLabelAptitude new) + (BrGlamorousCodeEditorAptitude new).
	
	toolbarElement addItem: bindingEditor.
]

{ #category : #accessing }
LeStringSnippetElement >> snippetContent [
	^ contentElement
]

{ #category : #accessing }
LeStringSnippetElement >> snippetToolbar [
	^ toolbarElement
]
