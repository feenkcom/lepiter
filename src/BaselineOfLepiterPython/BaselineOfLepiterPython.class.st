Class {
	#name : #BaselineOfLepiterPython,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterPython
}

{ #category : #accessing }
BaselineOfLepiterPython class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterPython >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				baseline: 'Gt4PythonBridge' with: [ 
					spec repository: 'github://feenkcom/gtoolkit-remote-python:main/src' ].
			spec
				baseline: 'Gt4DebugAdapterProtocol' with: [ 
					spec repository: 'github://feenkcom/gtoolkit-debugadapterprotocol:main/src' ].
			spec
				package: 'Lepiter-Python' with: [
					spec requires: #( 'LepiterEngineCore' 'Gt4PythonBridge' ) ] ]
]
