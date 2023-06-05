Class {
	#name : #LeHtmlContext,
	#superclass : #LeExportContext,
	#traits : 'TLeHtmlContext',
	#classTraits : 'TLeHtmlContext classTrait',
	#instVars : [
		'stream',
		'htmlStream',
		'page'
	],
	#category : #'Lepiter-HTML-! Core'
}

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
