Class {
	#name : #LeExampleUnnamedCustomPageType,
	#superclass : #LeUnnamedPageType,
	#instVars : [
		'theAnswer'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #initialization }
LeExampleUnnamedCustomPageType class >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
LeExampleUnnamedCustomPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: #theAnswer -> #theAnswer;
		yourself
]

{ #category : #accesing }
LeExampleUnnamedCustomPageType class >> leJsonV4Name [

	^ 'exampleUnnamedCustomPage'
]

{ #category : #printing }
LeExampleUnnamedCustomPageType class >> niceClassName [
	^ 'Example Unnamed Custom Page'
]

{ #category : #example }
LeExampleUnnamedCustomPageType class >> samplePage [
	| page |
	page := LePage new assignNewUID.
	page
		type: (LeExampleUnnamedCustomPageType new
				page: page;
				theAnswer: 42).
	page
		addSnippet: (page snippetBuilder
				text: 'testing' asRopedText;
				build).
	^ page
]

{ #category : #ui }
LeExampleUnnamedCustomPageType >> asPreviewElement [
	^ self defaultPhlowTool asElement
]

{ #category : #converting }
LeExampleUnnamedCustomPageType >> defaultPhlowTool [
	^ GtPhlowExplicitTool new withIconAptitude
		name: self page title;
		icon: BrGlamorousVectorIcons gt;
		stencil: [ BrFrame new matchParent
				addChild: (BrGlamorousVectorIcons perform: #largeGt) create asScalableElement;
				when: BlDoubleClickEvent
					do: [ :anEvent | anEvent currentTarget phlow spawnObject: self theAnswer ] ]
]

{ #category : #printing }
LeExampleUnnamedCustomPageType >> printOn: aStream [

	aStream 
		<< 'Unnamed custom page: ';
		<< self shortDescription
]

{ #category : #example }
LeExampleUnnamedCustomPageType >> samplePage [
	<gtExample>
	^ self class samplePage
]

{ #category : #accessing }
LeExampleUnnamedCustomPageType >> theAnswer [
	^ theAnswer ifNil: [ theAnswer := 42 ]
]

{ #category : #accessing }
LeExampleUnnamedCustomPageType >> theAnswer: anObject [
	theAnswer := anObject
]
