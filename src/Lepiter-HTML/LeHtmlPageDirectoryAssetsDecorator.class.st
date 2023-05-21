"
Given a {{gtMethod:LeHtmlPageDirectoryAssetsDecorator >> #rootDiretory | label=root directory}}, I create {{gtClass:LeFileAssetResource | label=HTML asset resource}} instances. 
I am useful in use cases, when HTML assets, e.g., CSS and JavaScript are under development. In this case, a {{gtClass:LeDatabase}} can be exported into HTML with those HTML assets using {{gtMethod:LeHtmlBookExporter>>#withFileAssets:}}. Similarly, {{gtClass:LePage}}  can be exported using {{gtMethod:LeHtmlPageExporter >> #withFileAssets:}}. 
"
Class {
	#name : #LeHtmlPageDirectoryAssetsDecorator,
	#superclass : #Object,
	#traits : 'TLeHtmlPageDecorator',
	#classTraits : 'TLeHtmlPageDecorator classTrait',
	#instVars : [
		'rootDiretory'
	],
	#category : #'Lepiter-HTML-Helpers'
}

{ #category : #'api - writing' }
LeHtmlPageDirectoryAssetsDecorator >> addResourcesInto: aResources [
	"Add extra (asset) files to a page HTML export."

	self allResources do: [ :aResource | aResources addResource: aResource ]
]

{ #category : #accessing }
LeHtmlPageDirectoryAssetsDecorator >> allResources [
	^ rootDiretory allFiles
		collect: [ :aFile | 
			| aResource |
			(aFile basename beginsWith: '.')
				ifFalse: [ aResource := LeFileAssetResource new
							sourceFile: aFile;
							path: (self convertFile: aFile) ]
				ifTrue: [ nil ] ]
		thenReject: #isNil
]

{ #category : #private }
LeHtmlPageDirectoryAssetsDecorator >> convertFile: aFile [
	^ (aFile relativeTo: rootDiretory parent)
]

{ #category : #'gt - extensions' }
LeHtmlPageDirectoryAssetsDecorator >> gtAllResourcesFor: aView [
	<gtView>
	rootDiretory ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'All resources';
		priority: 15;
		items: [ self allResources ];
		column: 'Name' text: [ :aResource | aResource path pathString ]
]

{ #category : #'gt - extensions' }
LeHtmlPageDirectoryAssetsDecorator >> gtLinkFilesFor: aView [
	<gtView>
	rootDiretory ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Link files (css)';
		priority: 10;
		items: [ self linkFiles ];
		column: 'Name' text: [ :aFile | (self convertFile: aFile) pathString ]
]

{ #category : #'gt - extensions' }
LeHtmlPageDirectoryAssetsDecorator >> gtScriptFilesFor: aView [
	<gtView>
	rootDiretory ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Script files (js)';
		priority: 12;
		items: [ self scriptFiles ];
		column: 'Name' text: [ :aFile | (self convertFile: aFile) pathString ]
]

{ #category : #'api - initialization' }
LeHtmlPageDirectoryAssetsDecorator >> initializeHTMLPageExporter: anExporter [
	"Configure a {{gtClass:LeHtmlPageExporterVisitor}} instance before a page export"

	anExporter shouldGenerateHeader: true.

	self linkRelativePaths
		do: [ :aRelativePath | 
			anExporter
				addLink: {'rel' -> 'stylesheet'.
						'href' -> aRelativePath pathString} ].

	self scriptRelativePaths
		do: [ :aRelativePath | 
			anExporter
				addScript: (LeHtmlScriptDefinition
						attributes: {'type' -> 'text/javascript'.
								'src' -> aRelativePath pathString}) ]
]

{ #category : #accessing }
LeHtmlPageDirectoryAssetsDecorator >> linkFiles [
	| allCssFiles aDictionary |
	allCssFiles := (rootDiretory allDirectoriesMatching: 'css')
		flatCollect: [ :aDirectory | aDirectory filesMatching: '*.css' ].
		
	aDictionary := OrderedDictionary new.
	allCssFiles do: [ :aFile | aDictionary at: aFile basename put: aFile ].
	
	^ aDictionary values sorted: [ :a :b | a basename < b basename ]
]

{ #category : #accessing }
LeHtmlPageDirectoryAssetsDecorator >> linkRelativePaths [
	^ self linkFiles collect: [ :aFile | self convertFile: aFile ]
]

{ #category : #accessing }
LeHtmlPageDirectoryAssetsDecorator >> localLinks [
	self linkFiles 
]

{ #category : #accessing }
LeHtmlPageDirectoryAssetsDecorator >> rootDiretory [
	"Return a directory that holds HTML assets, e.g., CSS and JavaScript files"

	<return: #FileReference>
	^ rootDiretory
]

{ #category : #accessing }
LeHtmlPageDirectoryAssetsDecorator >> rootDiretory: anObject [
	rootDiretory := anObject
]

{ #category : #accessing }
LeHtmlPageDirectoryAssetsDecorator >> scriptFiles [
	| allJsFiles aDictionary filteredJsFiles |
	allJsFiles := (rootDiretory allDirectoriesMatching: 'js')
		flatCollect: [ :aDirectory | aDirectory filesMatching: '*.js' ].
		
	"Include only CSS files of a latest version, 
	assuming that more recent versions are placed later in the collection."
	aDictionary := OrderedDictionary new.
	allJsFiles do: [ :aFile | aDictionary at: aFile basename put: aFile ].
	
	filteredJsFiles := aDictionary values.
	
	"jQuery must be placed before a boostrap."
	filteredJsFiles sort: [ :a :b | 
		| aPriorityA aPriorityB |
		aPriorityA := aPriorityB := 0.
		(a basename beginsWith: 'jquery') ifTrue: [
			aPriorityA := 10 ].
		(b basename beginsWith: 'jquery') ifTrue: [
			aPriorityB := 10 ].
		(a basename beginsWith: 'bootstrap') ifTrue: [
			aPriorityA := 5 ].
		(b basename beginsWith: 'bootstrap') ifTrue: [
			aPriorityB := 5 ].
			
		aPriorityA > aPriorityB ].
		
	^ filteredJsFiles
]

{ #category : #accessing }
LeHtmlPageDirectoryAssetsDecorator >> scriptRelativePaths [
	^ self scriptFiles collect: [ :aFile | self convertFile: aFile ]
]

{ #category : #'api - writing' }
LeHtmlPageDirectoryAssetsDecorator >> writeAssetFilesUsing: aXdWriter [
	"Write extra (asset) files to a page HTML export.
	
	Ignore."

	
]
