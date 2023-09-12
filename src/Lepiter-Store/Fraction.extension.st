Extension { #name : #Fraction }

{ #category : #'*Lepiter-Store' }
Fraction class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Subclasses can override this to provide custom mappings."
	| aLeModel numerator denominator |

	aLeModel := self new.
	numerator := aDictionary at: #numerator.
	denominator := aDictionary at: #denominator.
	aLeModel setNumerator: numerator denominator: denominator.
	^ aLeModel
]

{ #category : #'*Lepiter-Store' }
Fraction class >> leJsonV4Name [

	^ #fraction
]
