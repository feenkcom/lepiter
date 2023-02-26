"
I am an abstract class. 
My subclasses are responsible for {{gtMethod: LeHTMLPageDecorator>>#initializeHTMLPageExporter: | label=configuring}} and {{gtMethod: LeHTMLPageDecorator>>#initializeHTMLPageExporter: | label=adding}} additional asset files used for {{gtClass:LePage}} HTML exports.
I am used in {{gtMethod: XdWriter>>#lepiterIndexPage:withLocalAssets:}}. 

"
Class {
	#name : #LeHTMLPageDecorator,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Helpers'
}

{ #category : #testing }
LeHTMLPageDecorator class >> isAbstract [
	^ self name = #LeHTMLPageDecorator
]

{ #category : #'instance creation' }
LeHTMLPageDecorator class >> withLocalAssets: aBoolean [
	^ aBoolean
		ifTrue: [ LeHTMLPageLocalAssetsDecorator new ]
		ifFalse: [ LeHTMLPageRemoteAssetsDecorator new ]
]

{ #category : #'api - initialization' }
LeHTMLPageDecorator >> initializeHTMLPageExporter: anExporter [
	"Configure a {{gtClass:LeHtmlPageExporterVisitor}} instance before a page export"

	
]

{ #category : #accessing }
LeHTMLPageDecorator >> remoteLinks [
	"https://lepiter.io CSS links used for styling page HTML files"

	^ {'https://lepiter.io/assets/v1/src/css/bootstrap.css'.
		'https://lepiter.io/assets/v1/src/css/single.css'.
		'https://lepiter.io/assets/v3/src/css/snippets.css'.
		'https://lepiter.io/assets/v1/src/css/vs.css'}
]

{ #category : #accessing }
LeHTMLPageDecorator >> remoteScripts [
	"https://lepiter.io JavaScript files used in page HTML files"

	^ {'https://lepiter.io/assets/v1/src/js/datefns.min.js'.
		'https://lepiter.io/assets/v1/src/js/jquery.js'.
		'https://lepiter.io/assets/v1/src/js/bootstrap.js'.
		'https://lepiter.io/assets/v1/src/js/highlight.pack.js'.
		'https://lepiter.io/assets/v1/src/js/common.js'.
		'https://lepiter.io/assets/v1/src/js/single.js'.
		'https://lepiter.io/assets/v3/src/js/snippets.js'}
]

{ #category : #'api - writing' }
LeHTMLPageDecorator >> writeAssetFilesUsing: aXdWriter [
	"Write extra (asset) files to a page HTML export."

	
]
