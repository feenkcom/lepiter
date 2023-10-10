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
		'selectedPage',
		'hrefBuilder'
	],
	#category : #'Lepiter-HTML-Exporters'
}

{ #category : #accessing }
LeHtmlBookNavigationExporter >> content [
	^ content
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> database: aDatabase [
	self tocNodes: aDatabase tableOfContentsNodes
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> defaultHrefBuilder [
	^ LeExportFilenameAndExtensionHypertextReferenceBuilder new
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
LeHtmlBookNavigationExporter >> exportLogo [
	internalStream
		tag: #p
		class: 'le-logo'
		do: [ 
			internalStream
				inlineTag: #a 
				attributes: #( 
					'class' 'le-logo-link' 
					'href' 'https://gtoolkit.com'
					'alt' 'Glamorous Toolkit' )
				do: [
					internalStream
						inlineTag: #span
						class: 'le-logo-g'
						with: 'glamorous'.
					internalStream
						inlineTag: #span
						class: 'le-logo-t'
						with: 'toolkit' ].
			internalStream << ' '.
			internalStream
				inlineTag: #span
				class: 'le-logo-version'
				with: GtImage version versionString ]
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporter >> exportNavigation [
	"We export only the first node since it is the actual table of contents node.
	If we want to export also uncategorized pages, we need to change this logic."

	tocNodes ifNotEmpty: [ self exportChildren: tocNodes first children ]
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporter >> exportNavigationToggler [	
	internalStream 
		tag: #button
		attributes: #(
			'class' 'navbar-toggler' 
			'type' 'button'
			'data-toggle' 'collapse'
			'data-target' '#le-nav-collapsable'
			'arial-controls' 'le-nav-collapsable'
			'arial-expanded' 'false'
			'arial-label' 'Toggle navigation' )
		do: [
			internalStream
				tag: #i
				class: 'fas fa-bars'
				with: ''
		]

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
				ifFound: [ :anUrlLink | 
					self hrefBuilder hrefFromPageLink: anUrlLink ]
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
LeHtmlBookNavigationExporter >> hrefBuilder [
	<return: #TLeExportHypertextReferenceBuilder>
	^ hrefBuilder ifNil: [ hrefBuilder := self defaultHrefBuilder ]
]

{ #category : #accessing }
LeHtmlBookNavigationExporter >> hrefBuilder: aBuilder [
	hrefBuilder := aBuilder
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
