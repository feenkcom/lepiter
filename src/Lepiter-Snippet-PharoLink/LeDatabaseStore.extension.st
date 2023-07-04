Extension { #name : #LeDatabaseStore }

{ #category : #'*Lepiter-Snippet-PharoLink' }
LeDatabaseStore >> pharoLink [
	"Answer the Dictionary containing the PharoLink settings for this database"
	<return: #Dictionary>

	^ self dbProperties at: #pharoLink
		ifPresent: [ :aDictionary | aDictionary ]
		ifAbsent: [ Dictionary new ]
]

{ #category : #'*Lepiter-Snippet-PharoLink' }
LeDatabaseStore >> pharoLink: aDictionaryOrNil [

	self 
		updateProperty: #pharoLink
		value: aDictionaryOrNil
]

{ #category : #'*Lepiter-Snippet-PharoLink' }
LeDatabaseStore >> pharoLinkSettings [
	"Answer the initialised LePharoLinkSettings for this database"
	<return: #LePharoLinkSettings>

	^ LePharoLinkSettings new dbProperties: self
]
