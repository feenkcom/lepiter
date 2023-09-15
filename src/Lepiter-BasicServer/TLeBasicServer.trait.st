Trait {
	#name : #TLeBasicServer,
	#instVars : [
		'zincServer'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'Lepiter-BasicServer'
}

{ #category : #accessing }
TLeBasicServer classSide >> configurationClass [
	self explicitRequirement
]

{ #category : #'instance creation' }
TLeBasicServer classSide >> createDefaultWithNewZnServer [
	| zincServer |
	self assert: [ defaultInstance isNil ].
	zincServer := ZnServer 
		on: self configurationClass defaultPortNumber.
	^ self createDefaultWithZnServer: zincServer.
]

{ #category : #'instance creation' }
TLeBasicServer classSide >> createDefaultWithZnServer: aZnServer [
	self assert: [ defaultInstance isNil ].
	^ defaultInstance := self createWithZnServer: aZnServer
]

{ #category : #'instance creation' }
TLeBasicServer classSide >> createWithZnServer: aZnServer [
	"Create a server instance that does not use a default Zinc server and neither is set as default.
	Useful for testing purposes."

	^ self basicNew
		basicInitializeZincServerWith: aZnServer;
		initialize;
		yourself
]

{ #category : #accessing }
TLeBasicServer classSide >> defaultInstance [
	^ defaultInstance ifNil: [
		defaultInstance := self new ]
]

{ #category : #testing }
TLeBasicServer classSide >> isDefaultRunning [
	^ defaultInstance notNil and: [ 
		defaultInstance isRunning ]
]

{ #category : #actions }
TLeBasicServer classSide >> resetDefault [
	self stopDefault.
	defaultInstance := nil
]

{ #category : #actions }
TLeBasicServer classSide >> startDefault [
	self defaultInstance
		configuration: self configurationClass forCurrentEnvironment;
		start
]

{ #category : #actions }
TLeBasicServer classSide >> startLogging [
	NonInteractiveTranscriptLogger startFor: LeZincSignal.
]

{ #category : #actions }
TLeBasicServer classSide >> stopDefault [
	defaultInstance ifNil: [ ^ self ].
	self defaultInstance stop
]

{ #category : #initialization }
TLeBasicServer >> basicInitializeZincServerWith: aZnServer [
	zincServer := aZnServer
]

{ #category : #accessing }
TLeBasicServer >> configuration [
	^ self zincServer delegate configuration
]

{ #category : #accessing }
TLeBasicServer >> configuration: aSyncServerConfiguration [
	self zincServer delegate configuration: aSyncServerConfiguration.
	self updateAuthenticator.
]

{ #category : #initialization }
TLeBasicServer >> defaultDelegate [
	self explicitRequirement
]

{ #category : #initialization }
TLeBasicServer >> defaultZincServer [
	^ ZnServer default ifNil: [ 
		ZnServer defaultOn: self class configurationClass defaultPortNumber ]
]

{ #category : #accessing }
TLeBasicServer >> ensureCorrelationId: aRequest [ 
	aRequest headers 
		at:'X-Request-Id'
		put: UUID new asString 
		ifPresentMerge: [:existingValue :newValue | existingValue ]
]

{ #category : #'gt-extensions' }
TLeBasicServer >> gtOverviewFor: aView [
	<gtView>
	^ aView forward 
		title: 'Overview';
		object: [ self zincServer ];
		view: #gtOverviewFor:
]

{ #category : #'gt-extensions' }
TLeBasicServer >> gtViewRestEndpointsFor: aView [
	<gtView>
	^ self zincServer
		ifNil: [ aView empty ]
		ifNotNil: [ self zincServer delegate gtViewRestEndpointsFor: aView ]
]

{ #category : #initialization }
TLeBasicServer >> initialize [
	super initialize.
	zincServer ifNil: [ 
		"The Zinc server might be set before #initialize if the server is created 
		using #basicInitialize for testing purposes."
		zincServer := self defaultZincServer ].
	 
	zincServer delegate: self defaultDelegate.
	zincServer authenticator: LeBasicServerNoAuthenticator new.
	zincServer debugMode: true.
]

{ #category : #testing }
TLeBasicServer >> isRunning [
	^ self zincServer isRunning
]

{ #category : #accessing }
TLeBasicServer >> localhostUrl [
	^ ('http://localhost:{1}' format: {self port}) asZnUrl
]

{ #category : #'accessing - config' }
TLeBasicServer >> permissionsToken [
	"Todo check for token expiration"
	^ self configuration permissionsToken
]

{ #category : #accessing }
TLeBasicServer >> port [
	^ self zincServer port
]

{ #category : #accessing }
TLeBasicServer >> port: aNumber [
	^ self zincServer port: aNumber
]

{ #category : #actions }
TLeBasicServer >> start [
	self zincServer start
]

{ #category : #actions }
TLeBasicServer >> stop [
	self zincServer stop
]

{ #category : #private }
TLeBasicServer >> updateAuthenticator [
	self explicitRequirement
]

{ #category : #accessing }
TLeBasicServer >> zincServer [
	^ zincServer
]
