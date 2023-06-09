Extension { #name : #LeAttachedLink }

{ #category : #'*Lepiter-Extensions' }
LeAttachedLink >> gtSerializationFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Serialization';
		priority: 80;
		text: [String streamContents: [ :s | 
				LeJsonV4 uniqueInstance serialize: self on: s prettyPrint: true ]]
]
