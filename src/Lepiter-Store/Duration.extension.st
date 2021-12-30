Extension { #name : #Duration }

{ #category : #'*Lepiter-Store' }
Duration >> basicSeconds [
	"Allow the instance variables to be accessed directly for serialisation"

	^ seconds
]

{ #category : #'*Lepiter-Store' }
Duration >> basicSeconds: aNumber [
	"Allow the instance variables to be accessed directly for serialisation"

	seconds := aNumber
]

{ #category : #'*Lepiter-Store' }
Duration class >> leJsonV4AttributeMapping [
	"Answer the Array of attribute to store keys.
	Subclasses should override this with their attributes."

	^ { 
		#basicSeconds -> #seconds.
		#nanos -> #nanos }
]

{ #category : #'*Lepiter-Store' }
Duration class >> leJsonV4Name [

	^ #duration
]

{ #category : #'*Lepiter-Store' }
Duration >> nanos [
	"Allow the instance variables to be accessed directly for serialisation"

	^ nanos
]

{ #category : #'*Lepiter-Store' }
Duration >> nanos: anObject [
	"Allow the instance variables to be set directly for serialisation"

	^ nanos := anObject
]
