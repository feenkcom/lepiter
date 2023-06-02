Class {
	#name : #LeExportLogger,
	#superclass : #Object,
	#traits : 'TLeExportLogger',
	#classTraits : 'TLeExportLogger classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-HTML-Old-! New - Support'
}

{ #category : #'api - initialization' }
LeExportLogger >> context: aLeHtmlContext [
	self
		assert: [ aLeHtmlContext isNotNil ]
		description: [ 'Context must be non-nil' ].
	self
		assert: [ context isNil ]
		description: [ 'Context must be initialized only once' ].
	
	context := aLeHtmlContext
]

{ #category : #accessing }
LeExportLogger >> log [
	^ context log
]

{ #category : #'api - logging' }
LeExportLogger >> unsupportedSnippet: aLeSnippet [
	self log addItem: (LeExportUnsupportedSnippetLogItem new 
		snippet: aLeSnippet)
]
