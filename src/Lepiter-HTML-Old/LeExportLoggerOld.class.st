Class {
	#name : #LeExportLoggerOld,
	#superclass : #Object,
	#traits : 'TLeExportLogger',
	#classTraits : 'TLeExportLogger classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-HTML-Old-! New - Support'
}

{ #category : #'api - initialization' }
LeExportLoggerOld >> context: aLeHtmlContext [
	self
		assert: [ aLeHtmlContext isNotNil ]
		description: [ 'Context must be non-nil' ].
	self
		assert: [ context isNil ]
		description: [ 'Context must be initialized only once' ].
	
	context := aLeHtmlContext
]

{ #category : #accessing }
LeExportLoggerOld >> log [
	^ context log
]

{ #category : #'api - logging' }
LeExportLoggerOld >> unsupportedSnippet: aLeSnippet [
	self log addItem: (LeExportUnsupportedSnippetLogItem new 
		snippet: aLeSnippet)
]
