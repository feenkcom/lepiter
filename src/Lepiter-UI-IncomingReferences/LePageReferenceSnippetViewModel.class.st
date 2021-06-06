"
# Page reference snippet's view model
Is a very little snippet whose only purpose it to display reference to a page

"
Class {
	#name : #LePageReferenceSnippetViewModel,
	#superclass : #LeDynamicSnippetViewModel,
	#instVars : [
		'uid'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #accessing }
LePageReferenceSnippetViewModel >> page [
	"Return a referenced page"

	<return: #LePage>
	^ self snippetModel page
]

{ #category : #accessing }
LePageReferenceSnippetViewModel >> snippetElementClass [

	^ LePageReferenceButtonElement
]

{ #category : #accessing }
LePageReferenceSnippetViewModel >> uid [
	"We generate a new uid to uniquely identity this snupper view model"
	<return: #LeUID>

	^ uid ifNil: [ uid := self page database newUID ]
]
