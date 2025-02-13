Extension { #name : #LePage }

{ #category : #'*Lepiter-Snippet-Text' }
LePage >> gtShowHideCommentsFor: anAction [
	"<lePageAction>"
	self isNamedPage ifFalse: [ ^ anAction empty ].
	(self hasCommentSnippets)
		ifFalse: [ ^ anAction empty ].
	^ anAction button
		priority: 76;
		icon: BrGlamorousVectorIcons note;
		tooltip: 'Show / hide comments';
		id: GtInspectorInspectButtonId;
		action: [ :aButton | 
			"aButton phlow spawnTool: 
				(self notesPageFor: self) asPhlowTool"
				self inform: 'To be implemented' ]

]

{ #category : #'*Lepiter-Snippet-Text' }
LePage >> gtToggleCommentsActionFor: anAction [
	<lePageAction>
	self hasCommentSnippets ifFalse: [ ^ anAction empty ].
	^ anAction button
		id: LeOpenPageInNewWorldTabElementId;
		priority: 100;
		tooltip: 'Show / hide comments';
		icon: LeCommentSnippetElement noteIcon;
		action: [ :aButton | 
			| toggle |
			toggle := self allChildrenCommentSnippets first isHidden not.
			self allChildrenCommentSnippets do: [ :each | each isHidden: toggle ] ]
]

{ #category : #'*Lepiter-Snippet-Text' }
LePage >> hasGtTodo [

	"Report whether this page has a todo.
	Useful for finding all todos in a lepiter database:
		thisSnippet database pages  select: #hasGtTodo
	"

	^ (self deep: #children select: [ :child | 
		   (child isKindOf: LeTextSnippet) and: [ 
			   (child ast // #LeTodoAnnotationNode) notEmpty ] ]) notEmpty
]

{ #category : #'*Lepiter-Snippet-Text' }
LePage >> hasLinkNamed: aString [

	"Report whether this page contains a link with the given name.
	Useful to find all pages with a given link:
		thisSnippet database pages select: [ :each | each hasLinkNamed: 'todo' ]
	"

	^ (self deep: #children select: [ :child | 
		   (child isKindOf: LeTextSnippet) and: [ 
			   child ast // #LeDoubleBracketLinkNode anySatisfy: [ :link | 
				   link linkUID = aString ] ] ]) isNotEmpty


]

{ #category : #'*Lepiter-Snippet-Text' }
LePage >> hasUncompletedGtTodo [

	"Report whether this page has a todo.
	Useful for finding all uncompleted todos in a lepiter database:
		thisSnippet database pages  select: #hasUncompletedGtTodo
	"

	^ (self deep: #children select: [ :child | 
		   (child isKindOf: LeTextSnippet) and: [ 
			   child ast // #LeTodoAnnotationNode anySatisfy: [ :todo | 
				   todo isCompleted not ] ] ]) notEmpty
]
