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
			action: [ :aButton :aTab | 
				| aText aWardleyMap |
				aTab viewContentElement
					allChildrenBreadthFirstDetect: [ :each | each isKindOf: BrEditorElement ]
					ifFound: [ :editorElement | 
						aText := editorElement editor text.
						aWardleyMap := GtWardleyMapScriptImporter forString: aText asString.
						self snippetModel wardleyMap: aWardleyMap ]
					ifNone: [ self inform: 'Cannot find text editor with Wardley script' ] ];
		actionButtonLabel: 'Copy'
			action: [ Clipboard clipboardText: (self snippetModel wardleyMap asWardleyMapScript copyReplaceAll: String cr with: String lf)];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Model'
			tooltip: 'Inspect Wardley Map model'
			action: [ :aButton | aButton phlow spawnObject: self snippet wardleyMap ]
]

{ #category : #accessing }
LeWardleyMapSnippetViewModel >> snippetElementClass [
	^ LeWardleyMapSnippetElement
]
