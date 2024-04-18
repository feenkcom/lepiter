Class {
	#name : #LeStringSnippetElement,
	#superclass : #LeTextualSnippetElement,
	#instVars : [
		'contentElement',
		'toolbarElement',
		'stringEditor',
		'bindingEditor'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #'api - snippet view model' }
LeStringSnippetElement >> alignContentLeftBy: aNumber [
	stringEditor padding: ((stringEditor padding withLeft: aNumber) withRight: aNumber)
]

{ #category : #accessing }
LeStringSnippetElement >> editor [
	<return: #BrTextEditorModel>
	^ stringEditor editor
]

{ #category : #initialization }
LeStringSnippetElement >> go [
	| string bindingName sharedBindings binding |
	string := stringEditor text asString.
	self snippetViewModel contentString: string.
	bindingName := bindingEditor text asString.
	self snippetViewModel bindingName: bindingName.
	sharedBindings := self snippetViewModel snippetBindings.
	binding := sharedBindings bindingOf: bindingName asSymbol.
	binding value: string.
	^ "bindingName ->" string
]

{ #category : #initialization }
LeStringSnippetElement >> initialize [
	| indicatorElement playButton playInspectButton |
	
	super initialize.
	
	stringEditor := GtTextualCoderEditorElement new.
	stringEditor aptitudeDo: [ :aLook | aLook glamorousRegularDefaultFont ].
	stringEditor editor text: 'empty' asRopedText.
	
	stringEditor padding: (BlInsets top: 5 bottom: 5).
	stringEditor margin: BlInsets empty.
	stringEditor editor 
		addEventHandler: (LeEditorReachedBorderEventHandler new 
			snippetElement: self).
			
	stringEditor editor ensureNoUndoRedoShortcuts.
	
	indicatorElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularSmallSize
		foreground: BrGlamorousColors textMarkupColor);
		margin: (BlInsets top: 5 right: 5);
		text: 'String'.
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
	
	bindingEditor editor text: '' asRopedText.
	
	toolbarElement addItem: bindingEditor.
]

{ #category : #'api - snippet view model' }
LeStringSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	self updateCoderViewModel.
	
	"stringEditor text: (self snippetViewModel contentString ifNil: [ String new ]) asRopedText ."
	bindingEditor text: (self snippetViewModel bindingName ifNil: [ String new ]) asRopedText
]

{ #category : #accessing }
LeStringSnippetElement >> snippetContent [
	^ contentElement
]

{ #category : #accessing }
LeStringSnippetElement >> snippetToolbar [
	^ toolbarElement
]

{ #category : #'private - updating' }
LeStringSnippetElement >> updateCoderViewModel [
	stringEditor textualCoderViewModel: self snippetViewModel coderViewModel
]
