"
I generate new unique references that are used to reference snippets.
For example {{gtClass:LePictureSnippet}} has {{gtMethod:LePictureSnippet >> #reference}} that is automatically set once added to a database, see {{gtMethod:LePictureSnippet>>#onAddedToDatabase}}.
#Example
{{gtExample:LeModelExamples>>#pageTwoWithOneAttachmentPictures | codeExpanded=false | previewExpanded=true | previewHeight=600 | previewShow=#gtPageLiveFor:}}
"
Class {
	#name : #LeDatabaseReferenceIdBuilder,
	#superclass : #Object,
	#instVars : [
		'database',
		'referenceIds'
	],
	#category : #'Lepiter-Core-Index'
}

{ #category : #accessing }
LeDatabaseReferenceIdBuilder >> database [
	<return: #LeDatabase>
	^ database
]

{ #category : #accessing }
LeDatabaseReferenceIdBuilder >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #'api - building' }
LeDatabaseReferenceIdBuilder >> nextReference [
	<return: #String>
	| aNewReferenceId |
	self assert: database isNotNil.
	self assert: referenceIds isNotNil.

	aNewReferenceId := referenceIds nextReference.
	database snippetsIterator snippetsDo: [ :eachSnippet | 
		(eachSnippet isPictureSnippetWithReference: aNewReferenceId) 
			ifTrue: [ ^ self nextReference ] ].

	^ aNewReferenceId
]

{ #category : #accessing }
LeDatabaseReferenceIdBuilder >> referenceIds [
	<return: #LeDatabaseReferenceIds>
	^ referenceIds
]

{ #category : #accessing }
LeDatabaseReferenceIdBuilder >> referenceIds: aLeDatabaseReferenceIds [
	referenceIds := aLeDatabaseReferenceIds
]
