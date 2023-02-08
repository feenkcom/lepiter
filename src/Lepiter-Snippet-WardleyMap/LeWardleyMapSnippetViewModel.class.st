Class {
	#name : #LeWardleyMapSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#category : #'Lepiter-Snippet-WardleyMap-Snippet'
}

{ #category : #accessing }
LeWardleyMapSnippetViewModel >> gtWardleyScriptFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Wardley Script';
		priority: 9;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ GtWardleyMapParser gtStyler ];
		text: [ self snippetModel wardleyMap asWardleyMapScript ];
		actionUpdateButtonTooltip: 'Update Script';
		actionButtonLabel: 'Import'
			tooltip: 'Create a new Wardley script model'
			action: [ :aButton | 
				| aText aWardleyMap |
				aButton phlow firstParentWithView phlow firstChildWithView
					allChildrenBreadthFirstDetect: [ :each | each isKindOf: BrEditorElement ]
					ifFound: [ :editorElement | 
						aText := editorElement editor text.
						aWardleyMap := GtWardleyMapScriptImporter forString: aText asString.
						self snippet wardleyMap: aWardleyMap ] ];
		actionButtonLabel: 'Copy'
			action: [ Clipboard clipboardText: self snippet wardleyMap asWardleyMapScript ]
]

{ #category : #accessing }
LeWardleyMapSnippetViewModel >> snippetElementClass [
	^ LeWardleyMapSnippetElement
]
