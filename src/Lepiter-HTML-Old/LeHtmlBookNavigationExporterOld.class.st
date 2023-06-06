"
I export a {{gtClass:LeDatabase}}'s {{gtMethod:LeDatabase >> #tableOfContentsNodes | label=table of contents}} as HTML.
"
Class {
	#name : #LeHtmlBookNavigationExporterOld,
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
	#category : #'Lepiter-HTML-Old-Book Exporter'
}

{ #category : #accessing }
LeHtmlBookNavigationExporterOld >> content [
	^ content
]

{ #category : #accessing }
LeHtmlBookNavigationExporterOld >> database: aDatabase [
	self tocNodes: aDatabase tableOfContentsNodes
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporterOld >> export [
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
LeHtmlBookNavigationExporterOld >> exportChildren: aCollection [

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
LeHtmlBookNavigationExporterOld >> exportLogo [
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
LeHtmlBookNavigationExporterOld >> exportNavigation [
	internalStream
		tag: #div
		class: 'col-lg-3 le-nav-column'
		do: [
			internalStream
				tag: #div
				class: 'side-menu sticky-top navbar-expand-lg le-nav-scrollable le-nav-container'
				do: [
					internalStream
						tag: #header
						class: 'navbar navbar-light bg-white sticky-top px-3 le-nav-footer'
						do: [
							self exportNavigationToggler.
							self exportLogo. ].
				
				
					internalStream
						tag: #nav
						attributes: #(
							'id' 'le-nav-collapsable'
							'class' 'navbar-collapse collapse le-nav-root' )
						do: [  
							"We export only the first node since it is the actual table of contents node.
							If we want to export also uncategorized pages, we need to change this logic."
							
							tocNodes ifNotEmpty: [ 
								self exportChildren: tocNodes first children ] ] ] ]
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporterOld >> exportNavigationToggler [	
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
LeHtmlBookNavigationExporterOld >> exportNode: aNode [
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
LeHtmlBookNavigationExporterOld >> gtContentFor: aView [
	<gtView>
	^ aView textEditor
		title: 'HTML';
		priority: 5;
		text: [ self content ifNil: [ '' ] ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		actionUpdateButton
]

{ #category : #accessing }
LeHtmlBookNavigationExporterOld >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeHtmlBookNavigationExporterOld >> pageLinks: anObject [
	pageLinks := anObject
]

{ #category : #accessing }
LeHtmlBookNavigationExporterOld >> selectedPage [
	<return: #LePage>
	^ selectedPage
]

{ #category : #accessing }
LeHtmlBookNavigationExporterOld >> selectedPage: aLePage [
	selectedPage := aLePage
]

{ #category : #accessing }
LeHtmlBookNavigationExporterOld >> tocNodes [
	^ tocNodes
]

{ #category : #accessing }
LeHtmlBookNavigationExporterOld >> tocNodes: anObject [
	tocNodes := anObject
]

{ #category : #'api - initialization' }
LeHtmlBookNavigationExporterOld >> writeStream: aStream [
	externalStream := aStream
]
