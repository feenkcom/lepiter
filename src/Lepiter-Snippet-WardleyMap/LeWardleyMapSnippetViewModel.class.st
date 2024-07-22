Class {
	#name : #LeWardleyMapSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#instVars : [
		'wardleyMapViewModel'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Snippet'
}

{ #category : #private }
LeWardleyMapSnippetViewModel >> createWardleyViewModel [
	^ GtWardleyMapViewModel new
		wardleyMapModel: self snippetModel wardleyMap;
		wardleySnippetModel: self snippetModel
]

{ #category : #accessing }
LeWardleyMapSnippetViewModel >> gtWardleyScriptFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Wardley script';
		priority: 9;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ GtWardleyMapParser gtStyler ];
		text: [ self snippetModel wardleyMap asWardleyMapScript ];
		actionUpdateButtonTooltip: 'Update Script';
		actionButtonLabel: 'Import'
			tooltip: 'Create a new Wardley script model'
			action: [ :aButton | 
				| aText aWardleyMap |
				aText := aButton phlow textViewContent.
				aText
					ifNotNil: [ aWardleyMap := GtWardleyMapScriptImporter forString: aText asString.
						self snippetModel wardleyMap: aWardleyMap ]
					ifNil: [ self inform: 'Cannot find text editor with Wardley script' ] ];
		actionButtonLabel: 'Copy'
			action: [ Clipboard clipboardText: self snippet wardleyMap asWardleyMapScript ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Model'
			tooltip: 'Inspect Wardley Map model'
			action: [ :aButton | aButton phlow spawnObject: self snippetModel wardleyMap ]
]

{ #category : #'api - snippet model' }
LeWardleyMapSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.

	wardleyMapViewModel := self createWardleyViewModel
]

{ #category : #accessing }
LeWardleyMapSnippetViewModel >> snippetElementClass [
	^ LeWardleyMapSnippetElement
]

{ #category : #accessing }
LeWardleyMapSnippetViewModel >> wardleyMapViewModel [
	<return: #GtWardleyMapViewModel>
	^ wardleyMapViewModel ifNil: [ wardleyMapViewModel := self createWardleyViewModel ]
]
