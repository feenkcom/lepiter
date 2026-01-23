Extension { #name : #NeoJSONMapper }

{ #category : #'*Lepiter-Store' }
NeoJSONMapper >> for: smalltalkClass named: aSymbol do: block [
	"Execute the code in block to further customize the mapping for schemaName.
	Create and add a new standard object mapping for schemaName if necessary."

	^ self for: smalltalkClass do: block
]
