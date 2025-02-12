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

{ #category : #'api - testing' }
LeCommentSnippet >> isCommentSnippet [
	^ true
]

{ #category : #'api - accessing' }
LeCommentSnippet >> paragraphStyle [
	"Needed for the view models text styler."

	^ LeParagraphStyle text
]
