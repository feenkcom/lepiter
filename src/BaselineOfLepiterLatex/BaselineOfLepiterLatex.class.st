Class {
	#name : #BaselineOfLepiterLatex,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterLatex
}

{ #category : #baseline }
BaselineOfLepiterLatex >> baseline: spec [
	<baseline> 
	spec
		for: #common do: [
			spec
				package: 'Lepiter-Latex'
		]
]
