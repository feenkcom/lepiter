Trait {
	#name : #TLeExtensibleContentNodeVisitor,
	#classInstVars : [
		'componentVisitorClasses'
	],
	#category : #'Lepiter-Core-Visitor'
}

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> addComponentVisitorClass: aClass [
	self componentVisitorClasses add: aClass
]

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> componentVisitorClasses [
	^ componentVisitorClasses
		ifNil: [ componentVisitorClasses := OrderedCollection withAll: self defaultComponentVisitorClasses ]
]

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> defaultComponentVisitorClasses [
	^ #()
]

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> new [
	^ super new
		initializeComponentVisitors;
		yourself
]

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> removeComponentVisitorClass: aClass [
	self componentVisitorClasses remove: aClass ifAbsent: [  ]
]

{ #category : #initialization }
TLeExtensibleContentNodeVisitor >> initializeComponentVisitors [
	self class componentVisitorClasses
		do: [ :each | self addVisitor: each new ]
]
