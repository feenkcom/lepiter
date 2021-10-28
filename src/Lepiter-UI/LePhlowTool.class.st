Class {
	#name : #LePhlowTool,
	#superclass : #GtPhlowTool,
	#category : 'Lepiter-UI-Phlow Tools'
}

{ #category : #testing }
LePhlowTool class >> isAbstract [
	^ self name = #LePhlowTool 
]

{ #category : #accessing }
LePhlowTool >> icon [ 
	^ LeIcons lepiterIcon 
]

{ #category : #'api - accessing' }
LePhlowTool >> name [
	^ 'Lepiter'
]

{ #category : #'api - accessing' }
LePhlowTool >> object [
	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
LePhlowTool >> tabLook [
	^ BrGlamorousTabSwitcherWithIconAptitude
]

{ #category : #'api - accessing' }
LePhlowTool >> title [
	"Subclasses may override it to define more appropriate titles"
	^ 'Lepiter'
]
