Extension { #name : #LeDatabaseStore }

{ #category : #'*Lepiter-Python' }
LeDatabaseStore >> pythonBridge [
	"Answer the Dictionary containing the PythonBridge settings for this database"
	<return: #Dictionary>

	^ self dbProperties at: #pythonBridge
		ifPresent: [ :aDictionary | aDictionary ]
		ifAbsent: [ Dictionary new ]
]

{ #category : #'*Lepiter-Python' }
LeDatabaseStore >> pythonBridge: aDictionaryOrNil [

	self 
		updateProperty: #pythonBridge
		value: aDictionaryOrNil
]

{ #category : #'*Lepiter-Python' }
LeDatabaseStore >> pythonBridgeSettings [
	"Answer the initialised LePythonBridgeSettings for this database"
	<return: #LePythonBridgeSettings>

	^ LePythonBridgeSettings new dbProperties: self
]
