"
Write the supplied LeModel on to the stream as an HTML page.


To export a fragment to the supplied stream see {{gtMethod:name=LePage>>#asHTMLDocument}}.

"
Class {
	#name : #LeHtmlPageExporterVisitor,
	#superclass : #LeHtmlFragmentExporterVisitor,
	#instVars : [
		'scripts',
		'metaTags',
		'links',
		'internalStyles',
		'shouldGenerateHeader'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #accessing }
LeHtmlPageExporterVisitor class >> hideAndShowScript [
	"Answer the script to be used to hide and show expandable annotations"

	^ String streamContents: [ :stream |
		stream << '$(document).ready(function(){'; cr.
		#('.class_annotation' '.method_annotation') do: [ :cssClass |
			stream
				tab; << '	$(''';
					<< cssClass;
					<< ''').addClass("hidden_annotation");'; cr;
				tab; << '	$(''';
					<< cssClass;
					<< ''').click(function() {'; cr;
				tab; << 'var $this = $(this);';
				tab; << '	if ($this.hasClass("hidden_annotation")) {'; cr;
				tab; tab; << '$(this).removeClass("hidden_annotation").addClass("visible_annotation");'; cr;
				tab; << '} else {'; cr;
				tab; tab; << '$(this).removeClass("visible_annotation").addClass("hidden_annotation");'; cr;
				tab; << '}'; cr;
				<< '});'; cr ].
		stream << '});'; cr ].

]

{ #category : #initialization }
LeHtmlPageExporterVisitor >> addHideAndShowScript [
	"Add the annotation hide and show scripts to the receiver, along with the jQuery dependency"

	self addScript: (LeHtmlScriptDefinition
		attributes: { 
			'type' -> 'text/javascript'. 
			'src' -> 'https://code.jquery.com/jquery-1.7.min.js' }).
	self addScript: (LeHtmlScriptDefinition 
		source: self class hideAndShowScript
		attributes: { 'type' -> 'text/javascript' }).
]

{ #category : #adding }
LeHtmlPageExporterVisitor >> addInternalStyle: aString [
	"Add the supplied string as an internal style for the receiver"

	^ internalStyles add: aString.
]

{ #category : #adding }
LeHtmlPageExporterVisitor >> addLink: aCollection [
	"Add the link with the supplied collection of attributes (Association key: attributeName value: attributeValue"

	^ links add: aCollection.
]

{ #category : #adding }
LeHtmlPageExporterVisitor >> addMetaTag: aCollection [
	"Add the meta tag with the supplied collection of attributes (Association key: attributeName value: attributeValue"

	^ metaTags add: aCollection.
]

{ #category : #adding }
LeHtmlPageExporterVisitor >> addScript: aLeHtmlScriptDefinition [
	"Add the supplied script definition to the receiver"

	^ scripts add: aLeHtmlScriptDefinition.
]

{ #category : #initialization }
LeHtmlPageExporterVisitor >> initialize [ 

	super initialize.
	scripts := OrderedCollection new.
	metaTags := OrderedCollection new.
	links := OrderedCollection new.
	internalStyles := OrderedCollection new.
	shouldGenerateHeader := false.
]

{ #category : #accessing }
LeHtmlPageExporterVisitor >> shouldGenerateHeader [
	^ shouldGenerateHeader ifNil: [ false ]
]

{ #category : #accessing }
LeHtmlPageExporterVisitor >> shouldGenerateHeader: aBoolean [
	shouldGenerateHeader := aBoolean
]

{ #category : #visiting }
LeHtmlPageExporterVisitor >> visitPage: aLePage [

	self shouldGenerateHeader ifTrue: [
		self writeDocType.
		self writeHeadFor: aLePage.
		stream << '<body>'; cr.
		
		stream << '<div class="container">'; cr.
		
		stream
			<< '<h1>';
			<< aLePage title asHTMLString;
			<< '</h1>';
			cr	].
	
	super visitPage: aLePage.
	
	self shouldGenerateHeader ifTrue: [
		stream << '</div>'; cr.
	].
	
	self shouldGenerateHeader ifTrue: [
		self writeScriptsFor: aLePage.
		stream << '</body>'; cr.
		stream << '</html>'; cr ]
]

{ #category : #private }
LeHtmlPageExporterVisitor >> writeAttributes: attributes [

	attributes do: [ :attribute |
		stream
			<< attribute key;
			<< '="';
			<< attribute value;
			<< '" ' ].

]

{ #category : #private }
LeHtmlPageExporterVisitor >> writeDocType [

	stream << '<!DOCTYPE html>'; cr.
]

{ #category : #private }
LeHtmlPageExporterVisitor >> writeHeadFor: aLePage [

	stream
		<< '<html>'; cr;
		<< '<head>'; cr;
		<< '<title>';
		<< aLePage title;
		<< '</title>'; cr.
	self writeMetaTagsFor: aLePage.
	self writeLinksFor: aLePage.
	self writeInternalStylesFor: aLePage.
	stream
		<< '</head>'; cr.
]

{ #category : #private }
LeHtmlPageExporterVisitor >> writeInternalStylesFor: aLePage [

	internalStyles do: [ :style |
		stream 
			<< '<style>'; cr;
			<< style;
			<< '</style>'; cr ]
	
]

{ #category : #private }
LeHtmlPageExporterVisitor >> writeLinksFor: aLePage [

	links do: [ :attributes |
		stream << '<link '.
		self writeAttributes: attributes.
		stream << '/>'; cr ]
	
]

{ #category : #private }
LeHtmlPageExporterVisitor >> writeMetaTagsFor: aLePage [

	metaTags do: [ :attributes |
		stream << '<meta '.
		self writeAttributes: attributes.
		stream << '/>'; cr ]
	
]

{ #category : #private }
LeHtmlPageExporterVisitor >> writeScriptsFor: aLePage [

	scripts do: [ :script |
		script storeOn: stream ]

]
