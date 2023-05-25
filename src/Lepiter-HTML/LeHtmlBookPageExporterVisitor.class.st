Class {
	#name : #LeHtmlBookPageExporterVisitor,
	#superclass : #LeHtmlFragmentExporterVisitor,
	#instVars : [
		'scripts',
		'metaTags',
		'links',
		'internalStyles',
		'shouldGenerateHeader',
		'exportPart'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #accessing }
LeHtmlBookPageExporterVisitor class >> hideAndShowScript [
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
LeHtmlBookPageExporterVisitor >> addHideAndShowScript [
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
LeHtmlBookPageExporterVisitor >> addInternalStyle: aString [
	"Add the supplied string as an internal style for the receiver"

	^ internalStyles add: aString.
]

{ #category : #adding }
LeHtmlBookPageExporterVisitor >> addLink: aCollection [
	"Add the link with the supplied collection of attributes (Association key: attributeName value: attributeValue"

	^ links add: aCollection.
]

{ #category : #adding }
LeHtmlBookPageExporterVisitor >> addMetaTag: aCollection [
	"Add the meta tag with the supplied collection of attributes (Association key: attributeName value: attributeValue"

	^ metaTags add: aCollection.
]

{ #category : #adding }
LeHtmlBookPageExporterVisitor >> addScript: aLeHtmlScriptDefinition [
	"Add the supplied script definition to the receiver"

	^ scripts add: aLeHtmlScriptDefinition.
]

{ #category : #accessing }
LeHtmlBookPageExporterVisitor >> exportPart: aTLeHtmlPageExportPart [
	exportPart := aTLeHtmlPageExportPart
]

{ #category : #initialization }
LeHtmlBookPageExporterVisitor >> initialize [ 

	super initialize.
	scripts := OrderedCollection new.
	metaTags := OrderedCollection new.
	links := OrderedCollection new.
	internalStyles := OrderedCollection new.
	shouldGenerateHeader := false.
	exportPart := LeHtmlNoPageExportPart uniqueInstance
]

{ #category : #accessing }
LeHtmlBookPageExporterVisitor >> shouldGenerateHeader [
	^ shouldGenerateHeader ifNil: [ false ]
]

{ #category : #accessing }
LeHtmlBookPageExporterVisitor >> shouldGenerateHeader: aBoolean [
	shouldGenerateHeader := aBoolean
]

{ #category : #visiting }
LeHtmlBookPageExporterVisitor >> visitPage: aLePage [

	self shouldGenerateHeader ifTrue: [
		self writeDocType.
		self writeHeadFor: aLePage.
		stream << '<body>'; cr. ].

	stream 
		tag: #div
		class: 'content'
		do: [ 
				
			stream 
				tag: #div
				class: 'row le-row'
				do: [
		
					exportPart exportBodyContentPrecedingPart: (
						LeHtmlPageExportPartContext new 
							stream: stream;
							page: aLePage).
					
					stream 
						tag: #div
						class: 'col-lg-9 le-main-col'
						do: [
						
							stream 
								tag: #div
								class: 'container min-height py-5 le-main-container'
								do: [
					
									stream 
										tag: #main
										do: [
					
											stream
												inlineTag: #h1
												class: 'le-main-title'
												with: aLePage title asHTMLString.
					
											super visitPage: aLePage.
										]
								]
						]
				]
		].
		
	stream 
		tag: #footer
		class: 'text-center py-5 le-footer'
		do: [ 
			stream 
				tag: #p
				class: 'le-footer-credits'
				do: [
					stream escape: 'Powered by '.
					stream 
						inlineTag: #a
						attributes: #( 'class' 'le-footer-link' 'href' 'https://lepiter.com' )
						with: 'Lepiter'.
					stream << ' | '.
					stream 
						inlineTag: #a
						attributes: #( 'class' 'le-footer-link' 'href' 'https://feenk.com/privacy' )
						with: 'Privacy Policy'
				]
		].
	
	self shouldGenerateHeader ifTrue: [
		self writeScriptsFor: aLePage.
		stream << '</body>'; cr.
		stream << '</html>'; cr ]
]

{ #category : #private }
LeHtmlBookPageExporterVisitor >> writeAttributes: attributes [

	attributes do: [ :attribute |
		stream
			<< attribute key;
			<< '="';
			<< attribute value;
			<< '" ' ].

]

{ #category : #private }
LeHtmlBookPageExporterVisitor >> writeDocType [

	stream << '<!DOCTYPE html>'; cr.
]

{ #category : #private }
LeHtmlBookPageExporterVisitor >> writeHeadFor: aLePage [

	stream
		<< '<html land="en">'; cr;
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
LeHtmlBookPageExporterVisitor >> writeInternalStylesFor: aLePage [

	internalStyles do: [ :style |
		stream 
			<< '<style>'; cr;
			<< style;
			<< '</style>'; cr ]
	
]

{ #category : #private }
LeHtmlBookPageExporterVisitor >> writeLinksFor: aLePage [

	links do: [ :attributes |
		stream << '<link '.
		self writeAttributes: attributes.
		stream << '/>'; cr ]
	
]

{ #category : #private }
LeHtmlBookPageExporterVisitor >> writeMetaTagsFor: aLePage [

	metaTags do: [ :attributes |
		stream << '<meta '.
		self writeAttributes: attributes.
		stream << '/>'; cr ]
	
]

{ #category : #private }
LeHtmlBookPageExporterVisitor >> writeScriptsFor: aLePage [

	scripts do: [ :script |
		script storeOn: stream ]

]
