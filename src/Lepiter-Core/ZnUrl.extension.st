Extension { #name : #ZnUrl }

{ #category : #'*Lepiter-Core' }
ZnUrl >> asLepiterLinkReference [
	^ LeLinkExternalUrlReference forUrl: self asString
]

{ #category : #'*Lepiter-Core' }
ZnUrl >> gtViewMatchingOriginLinksFor: aView [
	<gtView>
	LeDatabasesRegistry uniqueInstance hasDatabasesLoaded 
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Lepiter outgoing links';
		priority: 105;
		object: [ self asLepiterLinkReference ];
		view: #gtViewDefaultMatchingOriginLinksFor:
]

{ #category : #'*Lepiter-Core' }
ZnUrl >> gtViewMatchingTargetLinksFor: aView [
	<gtView>
	LeDatabasesRegistry uniqueInstance hasDatabasesLoaded 
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Lepiter incoming links';
		priority: 100;
		object: [ self asLepiterLinkReference ];
		view: #gtViewDefaultMatchingTargetLinksFor:
]
