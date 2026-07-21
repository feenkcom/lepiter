"
I am an {{gtClass:BlElement}}.
I display {{gtClass:LeWordExplanation}}.
I am used by {{gtClass:LeWordSnippetElement}}, see {{gtMethod:LeWordSnippetElement>>#initializeContentElement}}.
## Example
{{gtExample:LeWordExamples>>#viewElement|codeExpanded=false|previewExpanded=true}}

"
Class {
	#name : #LeWordViewElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'explanation',
		'editorElement'
	],
	#category : 'Lepiter-Snippet-Words-UI Auxiliar Elements'
}

{ #category : #'api - editor' }
LeWordViewElement >> addEditorShortcut: aBrTextEditorInteraction [
	
	self editorElement addEditorShortcut: aBrTextEditorInteraction
]

{ #category : #initialization }
LeWordViewElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'private - accessing' }
LeWordViewElement >> editorElement [
	<return: #BrEditor>
	^ editorElement
]

{ #category : #'api - accessing' }
LeWordViewElement >> explanation [
	^ explanation
]

{ #category : #'api - accessing' }
LeWordViewElement >> explanation: anExplanation [
	explanation := anExplanation.
	self onExplanationChanged.
]

{ #category : #initialization }
LeWordViewElement >> initialize [
	super initialize.
	editorElement := self newEditorElement.
	self addChild: editorElement as: #editor.
	self hMatchParent; vFitContent.
]

{ #category : #'private - instance creation' }
LeWordViewElement >> newEditorElement [
	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude;
		beReadOnlyWithSelection;
		vFitContent;
		hMatchParent.
]

{ #category : #'private - hooks' }
LeWordViewElement >> onExplanationChanged [
	self updateEditorText
]

{ #category : #'private - updating' }
LeWordViewElement >> updateEditorText [
	| aText |
	aText := LeWordExplanationTextBuilder new
		explanation: self explanation;
		build.
	self editorElement text: aText
]
