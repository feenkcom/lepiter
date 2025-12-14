Class {
	#name : #LeAnnotationParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeAnnotationParseNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitAnnotationParse: self
]

{ #category : #accessing }
LeAnnotationParseNode >> contextMenuModelForHostElement: aHostElement [
	"Return a context menu that can be displayed as a context menu.
	See #hasContextMenuModel."

	<return: #BrMenu or: nil>
	^ nil
]

{ #category : #testing }
LeAnnotationParseNode >> hasContextMenuModel [
	"Return true if a given node can display context menu.
	See #contextMenuModelForHostElement:"

	<return: #Boolean>
	^ false
]
