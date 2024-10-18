"
LePharoClassPageType holds the playground for the named class. 

## Internal Representation and Key Implementation Points.

### Instance Variables
	pageClassName:		<Symbol>


### Implementation Points

"
Class {
	#name : #LePharoClassPageType,
	#superclass : #LePageType,
	#instVars : [
		'pageClassName'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LePharoClassPageType class >> pageClassName: aSymbol page: aLePage [

	^ self new 
		pageClassName: aSymbol;
		page: aLePage 
]

{ #category : #comparing }
LePharoClassPageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ pageClassName sameContentAs: anObject pageClassName
]

{ #category : #accessing }
LePharoClassPageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ self pageClassName
]

{ #category : #comparing }
LePharoClassPageType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ pageClassName hash
]

{ #category : #'api - testing' }
LePharoClassPageType >> isPharoClassPageType [
	^ true
]

{ #category : #accessing }
LePharoClassPageType >> pageClass [ 
	^ (pageClassName endsWith: ' class')
		ifTrue: [
			| instanceClassName | 
			instanceClassName := (pageClassName withoutSuffix: ' class') asSymbol.
			instanceClassName := self class environment at: instanceClassName.
			instanceClassName classSide ]
		ifFalse: [ 
			self class environment at: pageClassName asSymbol ]
]

{ #category : #accessing }
LePharoClassPageType >> pageClassName [
	<return: #Symbol>

	^ pageClassName
]

{ #category : #accessing }
LePharoClassPageType >> pageClassName: aSymbolOrString [
	"Set the receiver's class. The class name is stored as a Symbol or String."

	pageClassName := aSymbolOrString
]

{ #category : #printing }
LePharoClassPageType >> printOn: aStream [

	aStream
		<< 'Pharo Class Page: ';
		<< (pageClassName ifNil: [ '<none>' ])
]

{ #category : #accessing }
LePharoClassPageType >> title [

	^ pageClassName asString, ' Page'
]
