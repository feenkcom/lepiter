"
LePharoClassDatabase is specifically for managing class comments in an image.

It only stores one type of page, {{gtClass:LePharoClassCommentPageType}}.  Each page holds the comment for its corresponding class in a single {{gtClass:LeTextSnippet}}, which is automatically updated if the comment is changed externally.

There isn't a database monitor, and Individual pages must be manually saved back to the class using {{gtMethod:LePharoClassDatabase>>#savePage:}}.

"
Class {
	#name : #LePharoClassDatabase,
	#superclass : #LeAbstractDatabase,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'pagesByName'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #initialization }
LePharoClassDatabase >> initialize [

	super initialize.
	pagesByName := Dictionary new.
	self registerForClassCommentAnnouncements.
]

{ #category : #private }
LePharoClassDatabase >> onClassCommentChanged: aClassCommentedAnnouncement [
	| page snippet newComment |

	page := pagesByName at: aClassCommentedAnnouncement classCommented name ifAbsent: [ ^ self ].
	snippet := page children first.
	newComment := aClassCommentedAnnouncement newComment asString.
	snippet string = newComment ifTrue: [ ^ self ].

	snippet updateString: newComment.
]

{ #category : #private }
LePharoClassDatabase >> registerForClassCommentAnnouncements [
	"Register for class comment announcements so we can manage the cache"

	SystemAnnouncer uniqueInstance weak
		when: ClassCommented
		send: #onClassCommentChanged:
		to: self.
]

{ #category : #'api - accessing' }
LePharoClassDatabase >> savePage: aLePage [

	^ self savePageNamed: aLePage type pharoClassName
]

{ #category : #'api - accessing' }
LePharoClassDatabase >> savePageNamed: aSymbol [

	^ pagesByName at: aSymbol 
		ifPresent: [ :page | 
			self assert: page childrenCount equals: 1.
			(self class environment at: aSymbol) comment: page children first string ]
		ifAbsent: [ self error: 'Class comment not modified: ', aSymbol ]
]
