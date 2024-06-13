Extension { #name : #GtWardleyMapAction }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> isLinkToAnyLepiterPage [
	self lepiterPageOption
		ifNotNil: [ :aLinkedPage | ^ true ].
	self lepiterPageNameOption
		ifNotNil: [ :aLinkedPageName | ^ true ].
	self lepiterPageUidOption
		ifNotNil: [ :aLinkedPageUid | ^ true ].
	^ false
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> isLinkToLepiterPage: aLePage [
	self lepiterPageOption
		ifNotNil: [ :aLinkedPage | aLePage = aLinkedPage ifTrue: [ ^ true ] ].
	self lepiterPageNameOption
		ifNotNil: [ :aLinkedPageName | aLePage title asString = aLinkedPageName ifTrue: [ ^ true ] ].
	self lepiterPageUidOption
		ifNotNil: [ :aLinkedPageUid | aLePage uid = aLinkedPageUid ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> isLinkToLepiterPageNamed: aLePageName [
	self lepiterPageOption
		ifNotNil: [ :aLinkedPage | aLePageName = aLinkedPage title asString ifTrue: [ ^ true ] ].
	self lepiterPageNameOption
		ifNotNil: [ :aLinkedPageName | aLePageName = aLinkedPageName ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> isLinkToLepiterPageUid: aLePageUid [
	self lepiterPageUidOption
		ifNotNil: [ :aLinkedPageUid | aLePageUid = aLinkedPageUid ifTrue: [ ^ true ] ].
	self lepiterPageOption
		ifNotNil: [ :aLinkedPage | aLePageUid = aLinkedPage uid ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> lepiterPageNameOption [
	^ self optionAt: #lepiterPageName ifAbsent: [ nil ]
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> lepiterPageNameOption: aLePageName [
	self optionAt: #lepiterPageName put: aLePageName
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> lepiterPageOption [
	^ self optionAt: #lepiterPage ifAbsent: [ nil ]
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> lepiterPageOption: aLePage [
	self optionAt: #lepiterPage put: aLePage
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> lepiterPageUidOption [
	<return: #UUID>
	^ self optionAt: #lepiterPageUid ifAbsent: [ nil ]
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> lepiterPageUidOption: aLePageUid [
	self
		optionAt: #lepiterPageUid
		put: (aLePageUid isString ifTrue: [ UUID fromString36: aLePageUid ] ifFalse: [ aLePageUid ])
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> page: aLePage [
	self
		icon: LeIcons lepiterPage;
		tooltip: ('Navigate to the page named {1}' format: { aLePage title });
		action: [ :aButton | aButton phlow spawnTool: (LePagePhlowTool page: aLePage) ];
		lepiterPageOption: aLePage
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> pageNamed: aLePageName [
	self
		icon: LeIcons lepiterPage;
		"label: (self buttonLabelFromString: aLePageName);"
		tooltip: ('Navigate to the page named {1}' format: { aLePageName });
		action: [ :aButton | 
			LeDatabasesRegistry defaultLogicalDatabase
				pageNamed: aLePageName
				ifPresent: [ :aPage | 
					aButton phlow spawnTool: (LePagePhlowTool page: aPage) ]
				ifAbsent: [ 
					| aNotification |
					aNotification := GtNotificationMessage new 
						message: ('Page not found: {1}' format: { aLePageName }).
					aButton showNotification: aNotification ] ];
		lepiterPageNameOption: aLePageName
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapAction >> pageUid: aLePageUid [
	self
		icon: LeIcons lepiterPage;
		tooltip: ('Navigate to a page');
		action: [ :aButton | 
			LeDatabasesRegistry defaultLogicalDatabase
				pageWithID: aLePageUid
				ifPresent: [ :aPage | 
					aButton phlow spawnTool: (LePagePhlowTool page: aPage) ]
				ifAbsent: [ 
					| aNotification |
					aNotification := GtNotificationMessage new 
						message: ('Page not found: {1}' format: { aLePageUid }).
					aButton showNotification: aNotification ] ];
		lepiterPageUidOption: aLePageUid
]
