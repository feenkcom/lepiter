"
I exemplify the component visitor registry of {{gtClass:TLeExtensibleContentNodeVisitor}}.
Registering a component visitor class is idempotent, see {{gtExample:LeExtensibleContentNodeVisitorExamples>>#addComponentVisitorClassTwice}}.
"
Class {
	#name : #LeExtensibleContentNodeVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Support'
}

{ #category : #examples }
LeExtensibleContentNodeVisitorExamples >> addComponentVisitorClassTwice [
	<gtExample>
	<return: #OrderedCollection>
	| classes classesBefore aClass |
	classes := LeBlockLinksVisitor componentVisitorClasses.
	classesBefore := classes copy.
	aClass := classes first.
	[ LeBlockLinksVisitor
		addComponentVisitorClass: aClass;
		addComponentVisitorClass: aClass.
	self assert: (classes occurrencesOf: aClass) equals: 1.
	self assert: classes asArray equals: classesBefore asArray ]
		ensure: [ classes
				removeAll;
				addAll: classesBefore ].
	^ classes

]
