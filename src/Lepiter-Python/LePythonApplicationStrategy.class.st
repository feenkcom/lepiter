"
LePythonApplicationStrategy is responsible for answering the appropriate server to be used by the Python snippet.


"
Class {
	#name : #LePythonApplicationStrategy,
	#superclass : #LeExternalServerStrategy,
	#category : 'Lepiter-Python-Settings'
}

{ #category : #'instance creation' }
LePythonApplicationStrategy >> newPbApplicationFor: aLeDatabase [
	| newApp |

	newApp := PBApplication new.
	self updatedSettings: newApp settings.
	^ newApp
]

{ #category : #private }
LePythonApplicationStrategy >> updatedSettings: applicationPbSettings [
	"Update the supplied settings with the lepiter configuration"
	| lepiterPbSettings lepiterDatabase pbDir |

	lepiterDatabase := content database.
	lepiterPbSettings := lepiterDatabase properties pythonBridgeSettings.
	lepiterPbSettings directory ifNotNil:
		[ :relativeDir | 
			pbDir := lepiterDatabase localStoreRootDirectory resolve: relativeDir.
			applicationPbSettings workingDirectory: pbDir ].
	lepiterPbSettings pipenvPath ifNotNil:
		[ :pipenvPath | applicationPbSettings pipenvPath: pipenvPath ].
	applicationPbSettings serverDebugMode: lepiterPbSettings serverDebugMode.
	^ applicationPbSettings
]
