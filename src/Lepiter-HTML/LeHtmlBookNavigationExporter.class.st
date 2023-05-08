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
						internalStream := ZnHtmlOutputStream on: aStream.

						self exportNavigation ] ]
		ifNotNil: [ :aStream | 
			internalStream := ZnHtmlOutputStream on: aStream.

			self exportNavigation ]
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporter >> exportChildren: aCollection [
	level := level + 1.
	aCollection do: [ :aNode | 
		self exportNode: aNode ].
	level := level - 1.
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporter >> exportNavigation [
	internalStream
		tag: #div
		class: 'le-navigation-scrollable'
		do: [
			internalStream
				tag: #nav
				class: 'le-navigation-content'
				do: [  
					"We export only the first node since it is the actual table of contents node.
					If we want to export also uncategorized pages, we need to change this logic."
					
					tocNodes ifNotEmpty: [ 
						self exportChildren: tocNodes first children ] ] ]
]

{ #category : #'api - export' }
LeHtmlBookNavigationExporter >> exportNode: aNode [
	internalStream 
		tag: #div
		class: 'le-navigation-node le-navigation-level-' , level asString
		do: [
			aNode link
				ifNotNil: [ :aNodeLink | 
					| anUrl aSelectionClass |
					anUrl := pageLinks
							linkForPage: aNode page
							ifFound: [ :anUrlLink | anUrlLink fileName ]
							ifNone: [ '404.html' ].
							
					selectedPage 
						ifNotNil: [ :aPage | 
							(aNode page == aPage) 
								ifTrue: [ aSelectionClass := ' le-navigation-selected' ]
								ifFalse: [ aSelectionClass := ' le-navigation-unselected' ] ] 
						ifNil: [ aSelectionClass := '' ].
		
					internalStream 
						tag: #div 
						class: 'le-navigation-item'
							, aSelectionClass
							, ' le-navigation-level-', level asString
						do: [
							selectedPage 
								ifNotNil: [ :aPage | 
									(aNode page == aPage) 
										ifTrue: [
											internalStream escape: aNode page title ]
										ifFalse: [ 
											internalStream
												tag: #a
												attributes: {#class.
														'le-navigation-link', aSelectionClass.
														#href.
														anUrl}
												with: aNode page title ] ] ] ].
		
			aNode children ifNotEmpty: [ :aCollection | 
				internalStream
					tag: #div
					class: 'le-navigation-children le-navigation-level-' , level asString
					do: [ self exportChildren: aCollection ] ] ]
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
