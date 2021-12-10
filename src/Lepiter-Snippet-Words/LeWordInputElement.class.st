"
I am an {{gtClass:BlElement}}.
I am an input editor which is used to fill a word that should be explained.
I am used by {{gtClass:LeWordSnippetElement}}, see {{gtMethod:LeWordSnippetElement>>#initializeContentElement}}.
## Example
{{gtExample:LeWordExamples>>#inputElement|codeExpanded=false|previewExpanded=true}}

"
Class {
	#name : #LeWordInputElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'editorElement',
		'editorShortcuts'
	],
	#category : 'Lepiter-Snippet-Words-UI Auxiliar Elements'
}

{ #category : #'api - editor' }
LeWordInputElement >> addEditorShortcut: aBrTextEditorInteraction [
	
	editorShortcuts := editorShortcuts copyWith: aBrTextEditorInteraction.
	
	self editor addEditorShortcut: aBrTextEditorInteraction
]

{ #category : #initialization }
LeWordInputElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #'api - enablement' }
LeWordInputElement >> disable [
	self editorElement beReadOnlyWithSelection
]

{ #category : #'private - accessing' }
LeWordInputElement >> editor [
	^ self editorElement editor
]

{ #category : #'private - accessing' }
LeWordInputElement >> editorElement [
	<return: #BrEditor>
	^ editorElement
]

{ #category : #'api - enablement' }
LeWordInputElement >> enable [
	self editorElement beEditable.
	
	editorShortcuts do: [ :eachShortcut | 
		self editor addEditorShortcut: eachShortcut ]
]

{ #category : #initialization }
LeWordInputElement >> initialize [
	super initialize.
	
	editorShortcuts := Array empty.

	self addChild: self newLabelElement as: #label.
	self addChild: (editorElement := self newEditorElement) as: #editor.
	
	self hMatchParent; vFitContent.	

]

{ #category : #'private - instance creation' }
LeWordInputElement >> newEditorElement [
	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude + BrGlamorousInputFieldSpacingAptitude;
		"inputFilter: BrTextEditorAlphaNumericInputFilter new;"
		constraintsDo: [ :c | c linear vertical alignCenter ];
		vFitContentLimited;
		hMatchParent.
]

{ #category : #'private - instance creation' }
LeWordInputElement >> newLabelElement [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		text: 'Word';
		margin: (BlInsets top: 0 right: 5 bottom: 0 left: 0);
		constraintsDo: [ :c | c linear vertical alignCenter ];
		fitContent.
]

{ #category : #'api - editor' }
LeWordInputElement >> whenEditor: anEventClass do: anAction [
	self editor when: anEventClass do: anAction
]

{ #category : #'api - accessing' }
LeWordInputElement >> word: aWord [
	self editorElement text: aWord asRopedText
]
