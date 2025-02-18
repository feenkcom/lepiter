Class {
	#name : #BaselineOfLepiterLatex,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterLatex
}

{ #category : #baseline }
BaselineOfLepiterLatex >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
			baseline: 'LepiterEngineCore' with: [
				spec repository: 'github://feenkcom/lepiter:main/src' ].
				
				spec package: #'Lepiter-Latex' 
			with: [ spec requires: #('LepiterEngineCore') ] 
		]
]
