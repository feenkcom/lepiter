"
I illustrate the use of the {{gtClass:name=TDatabaseHolder}} trait.

For the examples, we do *not* initialize the database in our `initialize` method, but isntead lazily on the first access to `database`.

"
Class {
	#name : #DatabaseHolderExamples,
	#superclass : #Object,
	#traits : 'TDatabaseHolder',
	#classTraits : 'TDatabaseHolder classTrait',
	#category : #'Lepiter-Core-Examples-Utility'
}

{ #category : #example }
DatabaseHolderExamples >> dbAllPagesSize [
	^ 5
]

{ #category : #example }
DatabaseHolderExamples >> dbNamedPagesSize [
	^ 4
]

{ #category : #example }
DatabaseHolderExamples >> emptiedDatabase [
	"We remove all the pages."

	<gtExample>
	<return: #DatabaseHolderExamples>
	| eg |
	eg := self initializedDatabase.
	eg database pages do: #removeSelf.
	self assert: eg database pages isEmpty.
	^ eg
]

{ #category : #page }
DatabaseHolderExamples >> gtProjectPage [
	<lePage>
	<gtExample>
	<return: #LePage>
	^ (LePage named: 'GT')
		addSnippet: (LeTextSnippet new
				string: ' [[Project]]';
				yourself);
		yourself
]

{ #category : #page }
DatabaseHolderExamples >> gtbookTodoPage [
	<lePage>
	<gtExample>
	<return: #LePage>
	^ (LePage named: 'GT Book')
		addSnippet: (LeTextSnippet new
				string: ' [[GT]] [[ToDo]]';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'Work on the GT Book';
				yourself);
		yourself
]

{ #category : #initialization }
DatabaseHolderExamples >> initialize [
	"NB: For these examples, we do not explicitly initialize the transient database, but instead let it be initialized lazily upon the first access to #database."

	super initialize	"self initializeDatabase"
]

{ #category : #example }
DatabaseHolderExamples >> initializedDatabase [
	"Upon the first access to #database, the transient database will be initialized."

	<gtExample>
	<return: #DatabaseHolderExamples>
	| eg |
	eg := self class new.

	self assert: eg database isNotNil.
	self assert: eg database pages size equals: eg dbAllPagesSize.
	self assert: eg database pagesByName size equals: eg dbNamedPagesSize.

	^ eg
]

{ #category : #example }
DatabaseHolderExamples >> nilDatabase [
	"If we do not send #initializeDatabase or the #database accessor, the database will remain nil, and also no database views or actions will appear."

	<gtExample>
	<return: #DatabaseHolderExamples>
	| eg |
	eg := self.
	self assert: database isNil.
	^ eg
]

{ #category : #page }
DatabaseHolderExamples >> projectTagPage [
	<lePage>
	<gtExample>
	<return: #LePage>
	^ (LePage named: 'Project')
		addSnippet: (LeTextSnippet new
				string: '';
				yourself);
		yourself
]

{ #category : #page }
DatabaseHolderExamples >> todoTagPage [
	<lePage>
	<gtExample>
	<return: #LePage>
	^ (LePage named: 'ToDo')
		addSnippet: (LeTextSnippet new
				string: '';
				yourself);
		yourself
]

{ #category : #page }
DatabaseHolderExamples >> unnamedPage [
	<lePage>
	<gtExample>
	<return: #LePage>
	^ LePage unnamedPage yourself
]
