"
I am a hidable text snippet that can serve for comments on various parts of a Lepiter Page.
I am just like a {{gtClass:name=LeTextSnippet}}, except:
• my background is yellow (like a Post-it),
• by default I am hidden, but I can be displayed using a dedicated action,
• my database knows which pages have comments.
"
Class {
	#name : #LeCommentSnippet,
	#superclass : #LePlainTextSnippet,
	#instVars : [
		'isHidden'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #'api - accessing menu' }
LeCommentSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LeCommentSnippet class >> description [
	^ 'Comment'
]

{ #category : #factory }
LeCommentSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#isHidden -> #isHidden);
		yourself
]

{ #category : #factory }
LeCommentSnippet class >> leJsonV4Name [
	^ 'commentSnippet'
]

{ #category : #visiting }
LeCommentSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitTextSnippet: self
]

{ #category : #announcements }
LeCommentSnippet >> announceVisibilityChanged [
	self
		notifyAnnouncement: (LeCommentSnippetVisibilityChanged new
				snippet: self;
				yourself)
]

{ #category : #converting }
LeCommentSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeCommentSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeCommentSnippet >> hide [
	self isHidden: true
]

{ #category : #'api - testing' }
LeCommentSnippet >> isCommentSnippet [
	^ true
]

{ #category : #accessing }
LeCommentSnippet >> isHidden [
	^ isHidden ifNil: [ isHidden := false ]
]

{ #category : #accessing }
LeCommentSnippet >> isHidden: aBoolean [
	isHidden := aBoolean.
	self announceVisibilityChanged
]

{ #category : #'api - accessing' }
LeCommentSnippet >> paragraphStyle [
	"Needed for the view models text styler."

	^ LeParagraphStyle text
]

{ #category : #accessing }
LeCommentSnippet >> show [
	self isHidden: false
]

{ #category : #printing }
LeCommentSnippet >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new string: '.
	self string storeOn: aStream.
	aStream
		nextPutAll: '; isHidden: '.
	self isHidden storeOn: aStream.
	self childrenDo: [ :snippet | 
		aStream nextPutAll: '; addSnippet: '.
		snippet storeOn: aStream ].
	aStream nextPutAll: '; yourself)'
]
