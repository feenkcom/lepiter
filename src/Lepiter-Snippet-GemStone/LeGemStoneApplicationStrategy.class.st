Class {
	#name : 'LeGemStoneApplicationStrategy',
	#superclass : 'LeExternalServerStrategy',
	#category : 'Lepiter-Snippet-GemStone-Settings'
}

{ #category : 'instance creation' }
LeGemStoneApplicationStrategy >> newApplicationFor: aLeDatabase [
	| client |

	client := GtGemStoneClient new.
	self updatedSettings: client.
	^ client
]

{ #category : 'private' }
LeGemStoneApplicationStrategy >> updatedSettings: aGtGemStoneClient [
	"Update the supplied client with the lepiter configuration"
	| lepiterSettings lepiterDatabase |

	lepiterDatabase := content database.
	lepiterSettings := lepiterDatabase properties gemStoneSettings.
	lepiterSettings host ifNotNil:
		[ :host | aGtGemStoneClient host: host ].
	lepiterSettings port ifNotNil:
		[ :port | aGtGemStoneClient port: port ].
	^ aGtGemStoneClient
]
