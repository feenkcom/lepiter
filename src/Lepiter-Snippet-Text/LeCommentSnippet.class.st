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
LeCommentSnippet class >> leJsonV4Name [
	^ 'commentSnippet'
]

{ #category : #visiting }
LeCommentSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitTextSnippet: self
]

{ #category : #converting }
LeCommentSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeCommentSnippetViewModel new snippetModel: self
]

{ #category : #'as yet unclassified' }
LeCommentSnippet >> initialize [
	super initialize.
	self isHidden: false
]

{ #category : #'api - testing' }
LeCommentSnippet >> isCommentSnippet [
	^ true
]

{ #category : #accessing }
LeCommentSnippet >> isHidden [
	^ isHidden
]

{ #category : #accessing }
LeCommentSnippet >> isHidden: anObject [
	isHidden := anObject
]

{ #category : #'api - accessing' }
LeCommentSnippet >> paragraphStyle [
	"Needed for the view models text styler."

	^ LeParagraphStyle text
]
