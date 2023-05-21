"
I export a {{gtClass:LeDatabase}}'s {{gtMethod:LeDatabase >> #tableOfContentsNodes | label=table of contents}} as HTML.
"
Class {
	#name : #LeHtmlBookNavigationExporter,
	#superclass : #Object,
	#instVars : [
		'tocNodes',
		'pageLinks',
		'level',
		'content',
		'internalStream',
		'externalStream',
		'selectedPage'
	],
	#category : #'Lepiter-HTML-Book Exporter'
}

{ #category : #accessing }
LeHtmlBookNavigationExporter >> content [
	^ content
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> database: aDatabase [
	self tocNodes: aDatabase tableOfContentsNodes
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporter >> export [
	level := 0.

	externalStream
		ifNil: [ content := String
					streamContents: [ :aStream | 
						internalStream := LeHtmlOutputPrettyStream on: aStream.

						self exportNavigation ] ]
		ifNotNil: [ :aStream | 
			(aStream isKindOf: LeHtmlOutputPrettyStream)
				ifTrue: [ internalStream := aStream ]
				ifFalse: [ internalStream := LeHtmlOutputPrettyStream on: aStream ].

			self exportNavigation ]
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporter >> exportChildren: aCollection [

	internalStream 
		tag: #ul
		class: 'nav flex-column le-nav le-nav-level-', level asString
		do: [
			level := level + 1.
			aCollection do: [ :aNode | 
				self exportNode: aNode ].
			level := level - 1 ]
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporter >> exportNavigation [
	internalStream
		tag: #div
		class: 'col-lg-3'
		do: [
			internalStream
				tag: #div
				class: 'side-menu sticky-top pb-5 le-nav-scrollable'
				do: [
					internalStream
						tag: #header
						class: 'navbar navbar-light navbar-expand-lg bg-white sticky-top le-nav-footer'
						do: [
							internalStream
								tag: #p
								class: 'le-logo'
								do: [
									internalStream 
										inlineTag: #span
										class: 'le-logo-g'
										with: 'glamorous'.
									internalStream 
										inlineTag: #span
										class: 'le-logo-t'
										with: 'toolkit'.
									internalStream << ' '.
									internalStream 
										inlineTag: #span
										class: 'le-logo-book'
										with: 'book'.
									internalStream << ' '.
									internalStream 
										inlineTag: #span
										class: 'le-logo-version'
										with: GtImage  version  versionString ] ].
				
				
					internalStream
						tag: #nav
						class: 'le-nav-root'
						do: [  
							"We export only the first node since it is the actual table of contents node.
							If we want to export also uncategorized pages, we need to change this logic."
							
							tocNodes ifNotEmpty: [ 
								self exportChildren: tocNodes first children ] ] ] ]
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporter >> exportNode: aNode [
	| activeLink |
	selectedPage 
		ifNotNil: [ :aPage | 
			(aNode page == aPage) 
				ifTrue: [ activeLink := ' active' ]
				ifFalse: [ activeLink := '' ] ] 
		ifNil: [ activeLink := '' ].

	internalStream 
		tag: #li
		class: 'nav-item ', activeLink, 
			' le-nav-item le-nav-level-', level asString
		do: [
			| anUrl |
			anUrl := pageLinks
				linkForPage: aNode page
				ifFound: [ :anUrlLink | anUrlLink fileName ]
				ifNone: [ '/404.html' ].
			
		
			internalStream 
				tag: #a
				attributes: { 'class'. 
					'nav-link le-nav-link le-nav-level-', 
						level asString, activeLink. 
					'href'. anUrl } 
				with: aNode page title.
				
			aNode children ifNotEmpty: [ :aCollection | 
				self exportChildren: aCollection ] ].
]

{ #category : #'gt - extensions' }
LeHtmlBookNavigationExporter >> gtContentFor: aView [
	<gtView>
	^ aView textEditor
		title: 'HTML';
		priority: 5;
		text: [ self content ifNil: [ '' ] ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		actionUpdateButton
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> pageLinks: anObject [
	pageLinks := anObject
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> selectedPage [
	<return: #LePage>
	^ selectedPage
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> selectedPage: aLePage [
	selectedPage := aLePage
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> tocNodes [
	^ tocNodes
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> tocNodes: anObject [
	tocNodes := anObject
]

{ #category : #'api - initialization' }
LeHtmlBookNavigationExporter >> writeStream: aStream [
	externalStream := aStream
]
