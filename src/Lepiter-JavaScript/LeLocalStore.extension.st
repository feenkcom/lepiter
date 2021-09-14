Extension { #name : 'LeLocalStore' }

{ #category : '*Lepiter-JavaScript' }
LeLocalStore >> jsLink [
	"Answer the Dictionary containing the JSLink settings for this database"
	<return: #Dictionary>

	^ self dbProperties at: #jsLink
		ifPresent: [ :aDictionary | aDictionary ]
		ifAbsent: [ Dictionary new ]
]

{ #category : '*Lepiter-JavaScript' }
LeLocalStore >> jsLink: aDictionaryOrNil [

	self 
		updateProperty: #jsLink
		value: aDictionaryOrNil
]

{ #category : '*Lepiter-JavaScript' }
LeLocalStore >> jsLinkSettings [
	"Answer the initialised LePythonBridgeSettings for this database"
	<return: #LeJSLinkSettings>

	^ LeJSLinkSettings new dbProperties: self
]
