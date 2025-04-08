"
I iterate database snippets using the order of pages as defined in database table of contents.
"
Class {
	#name : #LeDatabaseToCSnippetsIterator,
	#superclass : #Object,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Core-Iterators'
}

{ #category : #accessing }
LeDatabaseToCSnippetsIterator >> database [
	<return: #LeDatabase>
	^ database
]

{ #category : #accessing }
LeDatabaseToCSnippetsIterator >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #accessing }
LeDatabaseToCSnippetsIterator >> orderedPagesDo: aBlock [
	self database ifNil: [ ^ #() ].
	self database tableOfContents 
		ifNotNil: [ :aToCPage | 	
			self database tableOfContentsNodes do: [ :eachTopNode |
				eachTopNode withAllChildrenDepthFirstDo: [ :eachNode | 
					aBlock value: eachNode page ] ] ]
		ifNil: [
			self database pagesDo: aBlock ]
]

{ #category : #'api - iterator' }
LeDatabaseToCSnippetsIterator >> snippetsDo: aBlock [
	self database ifNil: [ ^ self ].
	self orderedPagesDo: [ :eachPage | 
		eachPage allChildrenDepthFirstDo: [ :eachSnippet | 
			aBlock cull: eachSnippet
		]
	]
]
