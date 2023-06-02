Class {
	#name : #LeHtmlContext,
	#superclass : #LeExportContext,
	#instVars : [
		'stream',
		'htmlStream'
	],
	#category : #'Lepiter-HTML-! Core'
}

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
