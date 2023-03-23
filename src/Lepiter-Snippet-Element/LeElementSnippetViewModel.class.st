"
# Element snippet UI Model

Implementation detail:
I am a subset of the pharo snippet

"
Class {
	#name : #LeElementSnippetViewModel,
	#superclass : #LePharoSnippetViewModel,
	#instVars : [
		'displayElement'
	],
	#category : #'Lepiter-Snippet-Element-Snippet'
}

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> codeHeight [
	^ self snippetModel codeHeight
]

{ #category : #utils }
LeElementSnippetViewModel >> computeCodeHeightForElementHeight: anElementHeight [
	| aDelta |
	
	"is positive when increasing element height"
	aDelta := anElementHeight - self elementHeight.
	
	"should decrease code height first"
	^ (self codeHeight - aDelta) max: 0.
]

{ #category : #accessing }
LeElementSnippetViewModel >> displayElement [
	<return: #BlElement>

	^ displayElement
]

{ #category : #accessing }
LeElementSnippetViewModel >> displayElement: anElement [
	displayElement := anElement
]

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> doItAllRequestedBy: aRequesterObject [
	"Revaluate the content of the coder and return the result"
	<return: #Object>

	^ self coderViewModel doItAllRequestedBy: aRequesterObject
]

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> elementHeight [
	^ self snippetModel elementHeight
]

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> hideCode [
	| wasFocused |

	wasFocused := self focused.
	self coderViewModel focused: false.
	self snippetModel 
		updateIfRequiredCodeVisibility: false.
	self focused: wasFocused
]

{ #category : #initialization }
LeElementSnippetViewModel >> initialize [
	super initialize.
	
	displayElement := nil
]

{ #category : #'private - notifying' }
LeElementSnippetViewModel >> notifyCodeVisibilityChanged [
	self announce: (LeElementSnippetViewModelCodeVisibilityChanged new)
]

{ #category : #'private - notifying' }
LeElementSnippetViewModel >> notifyHeightChanged [
	self announce: (LeElementSnippetViewModelHeightChanged new)
]

{ #category : #'private - event handling' }
LeElementSnippetViewModel >> onCodeHeightChanged [
	self notifyHeightChanged
]

{ #category : #'private - event handling' }
LeElementSnippetViewModel >> onCodeVisibilityChanged [
	self notifyCodeVisibilityChanged
]

{ #category : #'private - event handling' }
LeElementSnippetViewModel >> onElementHeightChanged [
	self notifyHeightChanged
]

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> resizeElementHeightTo: aNewHeight [
	| newCodeHeight |
	
	newCodeHeight := self computeCodeHeightForElementHeight: aNewHeight.
	self snippetModel 
		updateIfRequiredElementHeight: self elementHeight 
			+ (self codeHeight - newCodeHeight)
		codeHeight: newCodeHeight
]

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> setElementHeightTo: aNewHeight [
	self snippetModel 
		updateIfRequiredElementHeight: aNewHeight
]

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> shouldShowCode [
	^ self snippetModel codeVisible
]

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> showCode [
	self snippetModel 
		updateIfRequiredCodeVisibility: true.
]

{ #category : #accessing }
LeElementSnippetViewModel >> snippetElementClass [
	^ LeElementSnippetElement
]

{ #category : #accessing }
LeElementSnippetViewModel >> snippetView [
	<return: #LeSnippetView>
	
	^ super snippetView needsContentDecorationBar: false
]

{ #category : #'api - snippet model' }
LeElementSnippetViewModel >> subscribeToSnippetModel [
	super subscribeToSnippetModel.
	
	self snippetModel weak when: LeElementSnippetElementHeightChanged
		send: #onElementHeightChanged
		to: self.

	self snippetModel weak when: LeElementSnippetCodeHeightChanged
		send: #onCodeHeightChanged
		to: self.
		
	self snippetModel weak when: LeElementSnippetCodeVisibilityChanged
		send: #onCodeVisibilityChanged
		to: self
]

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> temporaryResizeElementHeightTo: aNewHeight [
	| newCodeHeight |
	
	newCodeHeight := self computeCodeHeightForElementHeight: aNewHeight.
	
	self announce: (LeElementSnippetViewModelTemporaryHeightChanged new
		elementHeight: self elementHeight 
			+ (self codeHeight - newCodeHeight);
		codeHeight: newCodeHeight)
]

{ #category : #'api - snippet' }
LeElementSnippetViewModel >> temporarySetElementHeightTo: aNewHeight [
	self announce: (LeElementSnippetViewModelTemporaryHeightChanged new
		elementHeight: aNewHeight)
]

{ #category : #'api - snippet model' }
LeElementSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.

	self snippetModel unsubscribe: self
]
