Class {
	#name : #LePharoLinkApplicationStrategy,
	#superclass : #LeExternalServerStrategy,
	#category : 'Lepiter-Snippet-PharoLink-Settings'
}

{ #category : #'instance creation' }
LePharoLinkApplicationStrategy >> newApplicationFor: aLeDatabase [
	| settings |

	settings := LanguageLinkSettings pharoDefaultSettings.
	self updatedSettings: settings.
	^ PharoLinkApplication newWith: settings
]

{ #category : #private }
LePharoLinkApplicationStrategy >> updatedSettings: applicationSettings [
	"Update the supplied settings with the lepiter configuration"
	| lepiterSettings lepiterDatabase |

	lepiterDatabase := content database.
	lepiterSettings := lepiterDatabase properties pharoLinkSettings.
	lepiterSettings serverExecutable ifNotNil:
		[ :serverExe | applicationSettings serverExecutable: serverExe ].
	lepiterSettings serverImage ifNotNil:
		[ :serverImage | applicationSettings serverImage: serverImage ].
	lepiterSettings clientSocketAddress ifNotNil:
		[ :address | applicationSettings clientSocketAddress: address ].
	lepiterSettings serverSocketAddress ifNotNil:
		[ :address | applicationSettings serverSocketAddress: address ].
	applicationSettings serverDebugMode: lepiterSettings serverDebugMode.
	lepiterSettings manualProcess ifTrue: 
		[ applicationSettings serverProcessClass: LanguageLinkManualProcess ].
	^ applicationSettings
]
