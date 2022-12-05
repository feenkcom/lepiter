Extension { #name : #OmReference }

{ #category : #'*Lepiter-Store' }
OmReference class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self new
		initializeWithLocalName: (aDictionary at: #localName)
		globalName: (aDictionary at: #globalName)
]

{ #category : #'*Lepiter-Store' }
OmReference class >> leJsonV4Name [

	^ #omReference
]
