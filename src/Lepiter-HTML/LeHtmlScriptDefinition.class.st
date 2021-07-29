"
LeHtmlScriptDefinition holds the information needed to fill out an HTML script tag, i.e. a collection of key/value attributes and optional source string.

See {{gtMethod:name=LeHtmlPageExporterVisitor>>#addHideAndShowScript}} for example usage.

"
Class {
	#name : #LeHtmlScriptDefinition,
	#superclass : #Object,
	#instVars : [
		'source',
		'attributes'
	],
	#category : 'Lepiter-HTML-Model'
}

{ #category : #'instance creation' }
LeHtmlScriptDefinition class >> attributes: aCollection [

	^ self new attributes: aCollection
]

{ #category : #'instance creation' }
LeHtmlScriptDefinition class >> source: aString attributes: aCollection [

	^ self new 
		source: aString;
		attributes: aCollection
]

{ #category : #accessing }
LeHtmlScriptDefinition >> attributes [
	<return: #Collection of: #Association>

	^ attributes
]

{ #category : #accessing }
LeHtmlScriptDefinition >> attributes: anObject [
	attributes := anObject
]

{ #category : #initialization }
LeHtmlScriptDefinition >> initialize [

	super initialize.
	attributes := #().
]

{ #category : #accessing }
LeHtmlScriptDefinition >> source [
	"Answer the javascript source that defines the script or nil"
	<return: #String or: nil>

	^ source
]

{ #category : #accessing }
LeHtmlScriptDefinition >> source: anObject [
	source := anObject
]

{ #category : #printing }
LeHtmlScriptDefinition >> storeOn: aStream [
	"Write the receiver as html string on aStream"

	aStream << '<script '.
	attributes do: [ :attribute |
		aStream
			<< attribute key;
			<< '="';
			<< attribute value;
			<< '" ' ].
	aStream << '>'.
	source ifNotNil: 
		[ aStream
			cr;
			<< source;
			cr ].
	aStream << '</script>'; cr.
	
]
