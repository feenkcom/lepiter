Extension { #name : #LePage }

{ #category : #'*Lepiter-ToC' }
LePage >> gtMarkAsTableOfContentsFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons transcript;
		label: 'ToC';
		priority: 20;
		tooltip: 'Mark as Table of Contents';
		action: [ :aButton | self database tableOfContentsPageID: self uid  ]
]
