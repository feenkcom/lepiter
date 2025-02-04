"
I am a hidable text snippet that can serve for comments on various parts of a Lepiter Page.
I am just like a {{gtClass:name=LeTextSnippet}}, except:
• my background is yellow (like a Post-it),
• by default I am hidden, but I can be displayed using a dedicated action,
• my database knows which pages have comments.
"
Class {
	#name : #LeCommentSnippet,
	#superclass : #LeTextSnippet,
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
LeCommentSnippet class >> empty [
	"Return a block with empty comment"
	^ self builder
		emptyComment;
		build
]

{ #category : #factory }
LeCommentSnippet class >> leJsonV4Name [
	^ 'commentSnippet'
]

{ #category : #converting }
LeCommentSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeCommentSnippetViewModel new snippetModel: self
]

{ #category : #'api - testing' }
LeCommentSnippet >> isCommentSnippet [
	^ true
]
