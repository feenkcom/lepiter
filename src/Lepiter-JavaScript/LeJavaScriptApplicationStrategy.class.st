Class {
	#name : #LeJavaScriptApplicationStrategy,
	#superclass : #LeExternalServerStrategy,
	#category : 'Lepiter-JavaScript'
}

{ #category : #private }
LeJavaScriptApplicationStrategy >> newJavaScriptApplicationFor: aLeDatabase [

	^ JSLinkApplication new initializeWith: 
		(self updatedSettings: LanguageLinkSettings jsDefaultSettings).

]

{ #category : #private }
LeJavaScriptApplicationStrategy >> updatedSettings: applicationJsSettings [
	"Update the supplied settings with the lepiter configuration"
	| lepiterJsSettings lepiterDatabase jsDir |

	lepiterDatabase := content database.
	lepiterJsSettings := lepiterDatabase properties jsLinkSettings.
	lepiterJsSettings directory ifNotNil:
		[ :relativeDir | 
			jsDir := lepiterDatabase localStoreRootDirectory resolve: relativeDir.
			applicationJsSettings workingDirectory: jsDir ].
	lepiterJsSettings nodejsPath ifNotNil:
		[ :nodejsPath | applicationJsSettings serverExecutable: nodejsPath ].
	applicationJsSettings serverDebugMode: lepiterJsSettings serverDebugMode.

	^ applicationJsSettings
]
