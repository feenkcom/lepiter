Class {
	#name : #LeHtmlContext,
	#superclass : #LeExportContext,
	#traits : 'TLeHtmlContext',
	#classTraits : 'TLeHtmlContext classTrait',
	#instVars : [
		'stream',
		'htmlStream',
		'page',
		'pageLinks',
		'database',
		'date',
		'hrefBuilder',
		'author'
	],
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #accessing }
LeHtmlContext >> author [
	<return: #TLeHtmlAuthor or: nil>
	^ author
]

{ #category : #accessing }
LeHtmlContext >> author: anAuthor [
	author := anAuthor
]

{ #category : #accessing }
LeHtmlContext >> authorName: aString [
	aString ifNil: [ 
		author := nil.
		^ self ].
	self author: (LeHtmlAuthor new name: aString)
]

{ #category : #copying }
LeHtmlContext >> copyWithNewStream: aStream [
	| aCopy |
	aCopy := self copy.
	aCopy newStream: aStream
]

{ #category : #'api - accessing' }
LeHtmlContext >> database [
	<return: #LeDatabase>
	^ database
]

{ #category : #'api - accessing' }
LeHtmlContext >> database: aDatabase [
	database := aDatabase
]

{ #category : #accessing }
LeHtmlContext >> date [
	^ date
]

{ #category : #accessing }
LeHtmlContext >> date: anObject [
	date := anObject
]

{ #category : #accessing }
LeHtmlContext >> defaultHrefBuilder [
	^ LeExportFilenameAndExtensionHypertextReferenceBuilder new
]

{ #category : #initialization }
LeHtmlContext >> defaultPageLinks [
	^ LeExportPageLinksBuilder new
		in: [ :theBuilder | 
			database 
				ifNotNil: [ theBuilder database: database ]
				ifNil: [ theBuilder pages: { page } ] ];
		mainPage: page;
		sequencer: self sequencer;
		html;
		build;
		links
]

{ #category : #'gt - extensions' }
LeHtmlContext >> gtPageFor: aView [
	<gtView>
	page ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Page';
		priority: 30;
		object: [ page ];
		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
LeHtmlContext >> gtStreamStateFor: aView [
	<gtView>
	stream ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'HTML';
		priority: 10;
		object: [ stream ];
		view: #gtStreamStateFor:
]

{ #category : #accessing }
LeHtmlContext >> hrefBuilder [
	<return: #TLeExportHypertextReferenceBuilder>
	^ hrefBuilder ifNil: [ hrefBuilder := self defaultHrefBuilder ]
]

{ #category : #accessing }
LeHtmlContext >> hrefBuilder: aBuilder [
	hrefBuilder := aBuilder
]

{ #category : #'api - accessing' }
LeHtmlContext >> html [
	"Return HTML output stream.
	Currently we use {{gtClass:ZnHtmlOutputStream}} API to write HTML source code.
	{{gtClass:LeHtmlOutputPrettyStream}} is a pretty-print variant."

	<return: #ZnHtmlOutputStream>
	self
		assert: [ stream isNotNil ]
		description: [ 'Output stream must be non-nil' ].

	^ htmlStream
		ifNil: [ (stream isKindOf: ZnHtmlOutputStream)
				ifTrue: [ htmlStream := stream ]
				ifFalse: [ htmlStream := LeHtmlOutputPrettyStream on: stream ] ]
]

{ #category : #'api - initialization' }
LeHtmlContext >> newStream: aWriteStream [
	stream := nil.
	self stream: aWriteStream
]

{ #category : #'api - accessing' }
LeHtmlContext >> page [
	<return: #LePage>
	^ page
]

{ #category : #'api - initialization' }
LeHtmlContext >> page: aLePage [
	self 
		assert: [ aLePage isNotNil ] 
		description: [ 'Page must be non-nil' ].
	self
		assert: [ page isNil ]
		description: [ 'Page can be initialized only once' ].

	page := aLePage
]

{ #category : #accessing }
LeHtmlContext >> pageHref [
	^ self hrefBuilder hrefFromPageLink: self pageLink
]

{ #category : #accessing }
LeHtmlContext >> pageLink [
	^ self pageLinks
		linkForPage: page
		ifFound: [ :aPage | aPage ]
		ifNone: [ LeExportBookPageLink new
				page: page;
				fileName: 'index';
				fileExtension: 'html' ]
]

{ #category : #accessing }
LeHtmlContext >> pageLinks [
	^ pageLinks ifNil: [ pageLinks := self defaultPageLinks ]
]

{ #category : #accessing }
LeHtmlContext >> pageLinks: anObject [
	pageLinks := anObject
]

{ #category : #'api - initialization' }
LeHtmlContext >> stream: aWriteStream [
	self
		assert: [ aWriteStream isNotNil ]
		description: [ 'Output stream must be non-nil' ].
	self
		assert: [ stream isNil ]
		description: [ 'Output stream must be initialized only once' ].
	
	stream := aWriteStream
]
