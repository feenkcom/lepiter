"
I am an abstract class.
One of my subclasses is a main page in ${class:LeWorldElement}$, see ${method:LeWorldElement>>#defaultHomeElement}$.
I provide ${method:LeHomeBasicElement>>#updateContent|label=#selector}$.
See my ${class:LeHomeBasicElement|expanded|show=#gtSubclassesFor:}$ subclasses for concrete implementations:

"
Class {
	#name : #LeHomeBasicElement,
	#superclass : #LeDatabaseElement,
	#category : #'Lepiter-Tool-UI'
}

{ #category : #'api - updating' }
LeHomeBasicElement >> prepareForRelease [
	"Space sends this message to be saved as part of a release process.
	Subclasses may trigger relevant release actions.
	I am called from ${class:LeWorldElement}$"
]

{ #category : #'api - updating' }
LeHomeBasicElement >> updateContent [
	"I am called
	- when a ${class:LeWorld}$ is openned, see ${method:GtWorld>>#refreshContent}$, and
	- on system source code changes, see ${method:LeWorldElement>>#onSystemSourceCodeChanged:}$.
	I am called from a UI process."
]
