Extension { #name : #LeDatabaseNavigationModel }

{ #category : #'*Lepiter-ToC' }
LeDatabaseNavigationModel >> gtViewToCFor: aView [
	<gtView>
	<leDatabaseView>
	(self hasDatabase not or: [ self database tableOfContents isNil ])
		ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'ToC';
		priority: 1;
		stencil: [ LeDatabaseSidebarTreeElement new
				navigationModel: self;
				selectionBlock: [ self database tableOfContentsNodes ];
				expandSuchThat: [ :eachNode | eachNode value isToCNode ] ]
]
