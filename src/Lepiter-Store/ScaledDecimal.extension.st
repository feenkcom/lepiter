Extension { #name : #ScaledDecimal }

{ #category : #'*Lepiter-Store' }
ScaledDecimal class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Subclasses can override this to provide custom mappings."
	| aLeModel numerator denominator scale |

	aLeModel := self new.
	numerator := aDictionary at: #numerator.
	denominator := aDictionary at: #denominator.
	scale := aDictionary at: #scale.
	aLeModel setNumerator: numerator denominator: denominator scale: scale.
	^ aLeModel
]

{ #category : #'*Lepiter-Store' }
ScaledDecimal class >> leJsonV4Name [

	^ #scaledDecimal
]
