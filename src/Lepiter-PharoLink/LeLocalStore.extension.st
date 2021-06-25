Extension { #name : #LeLocalStore }

{ #category : #'*Lepiter-PharoLink' }
LeLocalStore >> pharoLink [
	"Answer the Dictionary containing the PharoLink settings for this database"
	<return: #Dictionary>

	^ self dbProperties at: #pharoLink
		ifPresent: [ :aDictionary | aDictionary ]
		ifAbsent: [ Dictionary new ]
]

{ #category : #'*Lepiter-PharoLink' }
LeLocalStore >> pharoLink: aDictionaryOrNil [

	self 
		updateProperty: #pharoLink
		value: aDictionaryOrNil
]

{ #category : #'*Lepiter-PharoLink' }
LeLocalStore >> pharoLinkSettings [
	"Answer the initialised LePharoLinkSettings for this database"
	<return: #LePharoLinkSettings>

	^ LePharoLinkSettings new dbProperties: self
]
