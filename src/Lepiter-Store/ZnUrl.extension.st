Extension { #name : #ZnUrl }

{ #category : #'*Lepiter-Store' }
ZnUrl >> asLepiterFileReference [
	"Convert the receiver to a file reference, allowing for FileLocator origin references.
	Currently the host must not be specified."
	| fileReferenceString |

	self assert: [ self isFile ]
		description: 'Only file URLs can be converted to a file reference'.
	self assert: [ host isNil ]
		description: 'The host must not be specified'.

	"If the path begins with a FileLocator origin, pass it as relative, otherwise absolute"
	fileReferenceString := (segments first first = ${)
		ifTrue: [ '/' join: segments ]
		ifFalse: [ self asFileReference pathString ].
	^ GtMacroFileReferenceEncoding new decodeFileReferenceString: fileReferenceString.
]

{ #category : #'*Lepiter-Store' }
ZnUrl >> lepiterDbUrlEquals: anObject [

	^ anObject lepiterDbUrlEqualsZnUrl: self
]

{ #category : #'*Lepiter-Store' }
ZnUrl >> lepiterDbUrlEqualsFileReference: aFileReference [

	self isFile ifFalse: [ ^ false ].
	^ self asLepiterFileReference resolve = aFileReference resolve
]

{ #category : #'*Lepiter-Store' }
ZnUrl >> lepiterDbUrlEqualsZnUrl: aZnUrl [

	scheme = aZnUrl scheme ifFalse: [ ^ false ].
	self isFile ifTrue: [ ^ self asLepiterFileReference resolve = aZnUrl asLepiterFileReference resolve ].
	^ self = aZnUrl
]
