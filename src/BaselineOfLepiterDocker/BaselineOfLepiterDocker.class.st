Class {
	#name : #BaselineOfLepiterDocker,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterDocker
}

{ #category : #accessing }
BaselineOfLepiterDocker >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				baseline: 'GToolkit4DockerEngine' with: [ 
					spec repository: 'github://feenkcom/gt4dockerengine:main/src' ].
			spec
				package: 'Lepiter-Snippet-Docker' with: [
					spec requires: #( 'LepiterEngineCore' 'GToolkit4DockerEngine') ] ]
]
