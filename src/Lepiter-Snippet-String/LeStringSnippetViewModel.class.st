Class {
	#name : #LeStringSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#category : #'Lepiter-Snippet-String'
}

{ #category : #accessing }
LeStringSnippetViewModel >> bindingName [
	^ self snippetModel bindingName
]

{ #category : #accessing }
LeStringSnippetViewModel >> bindingName: aNameString [
	^ self snippetModel bindingName: aNameString
]

{ #category : #accessing }
LeStringSnippetViewModel >> contentString [
	^ self snippetModel contentString
]

{ #category : #accessing }
LeStringSnippetViewModel >> contentString: aString [
	^ self snippetModel contentString: aString
]

{ #category : #accessing }
LeStringSnippetViewModel >> format [
	^ self snippet format
]

{ #category : #accessing }
LeStringSnippetViewModel >> format: aFormatString [
	^ self snippet format: aFormatString
]

{ #category : #accessing }
LeStringSnippetViewModel >> snippetElementClass [
	^ LeStringSnippetElement
]
