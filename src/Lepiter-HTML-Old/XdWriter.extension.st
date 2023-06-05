Extension { #name : #XdWriter }

{ #category : #'*Lepiter-HTML-Old' }
XdWriter >> addLepiterResourcesFor: aLePage [
	| resources |
	resources := aLePage resourcesVisitor compute.
	resources do: [ :eachResource | 
		eachResource fileReference binaryReadStreamDo: [ :stream | 
			self
				reuseOrAddAttachment: (GtFileUtility
					fileNameOf: eachResource fileReference
					relativeTo: aLePage database monitor localRoot asFileReference)
				stream: stream
				size: eachResource fileReference size ] ]
]

{ #category : #'*Lepiter-HTML-Old' }
XdWriter >> attachExportedFiles: aDataWriter [
	aDataWriter allFiles
		do: [ :eachFile | 
			eachFile
				binaryReadStreamDo: [ :aStream | 
					self
						attachment:
							(GtFileUtility
								fileNameOf: eachFile
								relativeTo: aDataWriter rootDirectory)
						stream: aStream
						size: eachFile size.] ]
]

{ #category : #'*Lepiter-HTML-Old' }
XdWriter >> lepiterIndexPage: aLePage [
	self lepiterIndexPage: aLePage decorator: nil
]

{ #category : #'*Lepiter-HTML-Old' }
XdWriter >> lepiterIndexPage: aLePage decorator: anExportDecorator [
	| picturesWriter exportVisitor htmlContent |
	self
		documentType: LeXdPageType;
		attachment: 'index.json'
			text: (String streamContents: [ :s | 
				LeJsonV4 uniqueInstance 
					serialize: aLePage 
					on: s 
					prettyPrint: true ]).
				
	picturesWriter := LeResourcesExporter new.
	exportVisitor := LeHtmlPageExporterVisitor new 
		shouldGenerateHeader: false;
		externalPicturesWriter: picturesWriter.
	anExportDecorator ifNotNil: [ 
		anExportDecorator initializeHTMLPageExporter: exportVisitor ].
	htmlContent := String streamContents: [ :stream |
		exportVisitor stream: stream.
		aLePage acceptVisitor: exportVisitor ].
	
	self
		documentType: XdType html;
		attachment: 'index.html' text: htmlContent.
	
	self addLepiterResourcesFor: aLePage.
	self attachExportedFiles: picturesWriter.

	anExportDecorator ifNotNil: [ 
		anExportDecorator writeAssetFilesUsing: self ].
		
	self title: aLePage title.
	self authorName: aLePage createEmail email.
	
	self preview.
]

{ #category : #'*Lepiter-HTML-Old' }
XdWriter >> lepiterIndexPage: aLePage withLocalAssets: aBoolean [
	self
		lepiterIndexPage: aLePage
		decorator: (LeHtmlPageDecorator withLocalAssets: aBoolean)
]
