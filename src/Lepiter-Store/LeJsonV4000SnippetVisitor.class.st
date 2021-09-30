Class {
	#name : #LeJsonV4000SnippetVisitor,
	#superclass : #LeContentNodeVisitor,
	#instVars : [
		'snippetString',
		'updater',
		'substitutions'
	],
	#category : 'Lepiter-Store-JsonV4'
}

{ #category : #initialization }
LeJsonV4000SnippetVisitor >> initialize [

	super initialize.
	substitutions := OrderedCollection new.
]

{ #category : #accessing }
LeJsonV4000SnippetVisitor >> snippetString [
	^ snippetString
]

{ #category : #accessing }
LeJsonV4000SnippetVisitor >> snippetString: anObject [
	snippetString := anObject
]

{ #category : #accessing }
LeJsonV4000SnippetVisitor >> updatedSnippetString [
	"Answer the string with updated snippet UIDs"
	| currentPosition |

	substitutions ifEmpty: [ ^ snippetString ].
	currentPosition := 1.
	^ String streamContents: [ :stream |
		substitutions do: [ :each |
			stream 
				<< (snippetString copyFrom: currentPosition to: each first);
				<< each second.
			currentPosition := each third ].
		stream << (snippetString copyFrom: currentPosition to: snippetString size) ].
	
]

{ #category : #accessing }
LeJsonV4000SnippetVisitor >> updater [
	^ updater
]

{ #category : #accessing }
LeJsonV4000SnippetVisitor >> updater: anObject [
	updater := anObject
]

{ #category : #generated }
LeJsonV4000SnippetVisitor >> visitBlockLink: aBlockLink [
	| oldUidString newUidString start end |

	start := aBlockLink startPosition.
	end := aBlockLink stopPosition.
	oldUidString := snippetString copyFrom: start + 2 to: end - 2.
	newUidString := updater cleanUidString: oldUidString.
	newUidString = oldUidString ifFalse:
		[ substitutions add: { start + 1. newUidString. end - 1. } ].
]
