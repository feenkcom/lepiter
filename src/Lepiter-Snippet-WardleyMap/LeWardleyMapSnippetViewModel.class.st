Class {
	#name : #LeWardleyMapSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#category : #'Lepiter-Snippet-WardleyMap-Snippet'
}

{ #category : #accessing }
LeWardleyMapSnippetViewModel >> gtWardleyScriptFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Wardley Script';
		priority: 9;
		object: [ self snippetModel ];
		view: #gtWardleyScriptFor:
]

{ #category : #accessing }
LeWardleyMapSnippetViewModel >> snippetElementClass [
	^ LeWardleyMapSnippetElement
]
