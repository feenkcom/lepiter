Extension { #name : #LeDatabaseStore }

{ #category : #'*Lepiter-JavaScript' }
LeDatabaseStore >> jsLink [
	"Answer the Dictionary containing the JSLink settings for this database"
	<return: #Dictionary>

	^ self dbProperties at: #jsLink
		ifPresent: [ :aDictionary | aDictionary ]
		ifAbsent: [ Dictionary new ]
]

{ #category : #'*Lepiter-JavaScript' }
LeDatabaseStore >> jsLink: aDictionaryOrNil [

	self 
		updateProperty: #jsLink
		value: aDictionaryOrNil
]

{ #category : #'*Lepiter-JavaScript' }
LeDatabaseStore >> jsLinkSettings [
	"Answer the initialised LeJSLinkSettings for this database"
	<return: #LeJSLinkSettings>

	^ LeJSLinkSettings new dbProperties: self
]
