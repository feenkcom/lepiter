Class {
	#name : #LeWardleyMapNodeToPageMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#category : #'Lepiter-Snippet-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
LeWardleyMapNodeToPageMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	aContextMenuItem wardleySnippetModel ifNil: [ ^ nil ].
	
	^ LeWardleyMapNodeToPageLinkElement new
		wardleyMapNodeViewModel: aContextMenuItem wardleyMapNodeViewModel;
		snippetModel: aContextMenuItem wardleySnippetModel
]

{ #category : #'gt - extensions' }
LeWardleyMapNodeToPageMenuItem >> gtItemName [
	^ 'Lepiter page linker'
]
