Extension { #name : #GtPharoMethodCoder }

{ #category : #'*Lepiter-Store-Class' }
GtPharoMethodCoder >> gtLepiterPageStoreFor: anAST into: coderAddOns [
	<gtCoderContextMenuAddOns: 202>
	(anAST methodNode isNil
		or: [ anAST methodNode pragmas
				noneSatisfy: [ :each | each selector = #lepiterPageStore ] ])
		ifTrue: [ ^ self ].
	coderAddOns
		addContextMenuItem: 'Inspect Lepiter Page' translated
		group: BrMenuItemGroupConfiguration navigation
		hover: nil
		leave: nil
		action: [ :aCoderUIModel :anEvent | 
			self
				notifyObjectSpawn: (LeDatabaseClassJsonV4Storage new loadFromMethod: self compiledMethod)
				requesterObject: aCoderUIModel ]
		id: nil
]
