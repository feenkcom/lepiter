Extension { #name : 'LeLocalStore' }

{ #category : '*Lepiter-Snippet-GemStone' }
LeLocalStore >> gemStone [
	"Answer the Dictionary containing the GemStone settings for this database"
	<return: #Dictionary>

	^ self dbProperties at: #gemStone
		ifPresent: [ :aDictionary | aDictionary ]
		ifAbsent: [ Dictionary new ]
]

{ #category : '*Lepiter-Snippet-GemStone' }
LeLocalStore >> gemStone: aDictionaryOrNil [

	self 
		updateProperty: #gemStone
		value: aDictionaryOrNil
]

{ #category : '*Lepiter-Snippet-GemStone' }
LeLocalStore >> gemStoneSettings [
	"Answer the initialised LeGemStoneSettings for this database"
	<return: #LeGemStoneSettings>

	^ LeGemStoneSettings new dbProperties: self
]
