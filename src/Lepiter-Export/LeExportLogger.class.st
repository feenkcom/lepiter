Class {
	#name : #LeExportLogger,
	#superclass : #Object,
	#traits : 'TLeExportLogger',
	#classTraits : 'TLeExportLogger classTrait',
	#instVars : [
		'log'
	],
	#category : #'Lepiter-Export-Log - Builders'
}

{ #category : #accessing }
LeExportLogger >> log [
	^ log
]

{ #category : #accessing }
LeExportLogger >> log: anObject [
	log := anObject
]

{ #category : #'api - logging' }
LeExportLogger >> missingChangesSnippetFile: aLeSnippetViewModel [
	self log addItem: (LeExportMissingChangesSnippetFileLogItem new 
		snippetViewModel: aLeSnippetViewModel)
]

{ #category : #'api - logging' }
LeExportLogger >> tooManyResources: aResources annotation: anAnnotation snippet: aSnippet [
	self log addItem: (LeExportTooManyAnnotationResourcesLogItem new 
		snippet: aSnippet;
		annotation: anAnnotation;
		resources: aResources)
]

{ #category : #'api - logging' }
LeExportLogger >> unsupportedSnippet: aLeSnippet [
	self log addItem: (LeExportUnsupportedSnippetLogItem new 
		snippet: aLeSnippet)
]

{ #category : #'api - logging' }
LeExportLogger >> withoutResourcesAnnotation: anAnnotation snippet: aSnippet [
	self log addItem: (LeExportMissingAnnotationResourcesLogItem new 
		snippet: aSnippet;
		annotation: anAnnotation)
]
