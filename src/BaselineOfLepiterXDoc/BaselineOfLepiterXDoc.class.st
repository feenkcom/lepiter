Class {
	#name : #BaselineOfLepiterXDoc,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterXDoc
}

{ #category : #baseline }
BaselineOfLepiterXDoc >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Xdoc' with: [
				spec repository: 'github://feenkcom/xdoc:v0.8.804/src' ].

		spec package: 'Lepiter-XDoc' with: [
			spec requires: #(#Xdoc) ].
	]
]
