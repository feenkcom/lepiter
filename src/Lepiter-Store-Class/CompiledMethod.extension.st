Extension { #name : #CompiledMethod }

{ #category : #'*Lepiter-Store-Class' }
CompiledMethod >> gtInspectLepiterPageFor: anAction [
	<gtAction>

	(self hasPragmaNamed: #lepiterPageStore) ifFalse: [ ^ anAction noAction ].
	^ anAction button
		label: 'Page';
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect Page';
		action: [ :button | button phlow spawnObject: 
			(LeDatabaseClassJsonV4Storage new loadFromMethod: self) ]
]
