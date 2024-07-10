Extension { #name : #LeVolatileMonitor }

{ #category : #'*Lepiter-Python' }
LeVolatileMonitor >> pythonBridge [
	"Answer the Dictionary containing the PythonBridge settings for this database"
	<return: #Dictionary>

	^ self dbProperties at: #pythonBridge
		ifPresent: [ :aDictionary | aDictionary ]
		ifAbsent: [ Dictionary new ]
]

{ #category : #'*Lepiter-Python' }
LeVolatileMonitor >> pythonBridgeSettings [
	"Answer the initialised LePythonBridgeSettings for this database"
	<return: #LePythonBridgeSettings>

	^ LePythonBridgeSettings new dbProperties: self
]
