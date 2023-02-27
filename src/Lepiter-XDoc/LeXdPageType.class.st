"
I indicate that the file corresponds to an exported Lepiter page.
"
Class {
	#name : #LeXdPageType,
	#superclass : #XdType,
	#category : #'Lepiter-XDoc'
}

{ #category : #accessing }
LeXdPageType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'lepiter-page'
]
