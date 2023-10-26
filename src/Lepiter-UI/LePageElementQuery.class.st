Class {
	#name : #LePageElementQuery,
	#superclass : #BlElementQueryWrapper,
	#category : #'Lepiter-UI-Query'
}

{ #category : #accessing }
LePageElementQuery >> firstSnippetInPage [
	^ self pageContent
		lepiterQuery snippetsTree
		lepiterQuery snippetAtIndex: 1
]

{ #category : #accessing }
LePageElementQuery >> pageContent [
	^ self ensureOne: targetQuery // LePageToolContentTreeElement
]

{ #category : #accessing }
LePageElementQuery >> snippetAtIndex: aSnippetIndex [
	^ self ensureOne: (targetQuery
		// LeSnippetElementId) 
			@ aSnippetIndex
]

{ #category : #accessing }
LePageElementQuery >> snippetsTree [
	^ self ensureOne: targetQuery // LePageSnippetsTreeElementId
]
