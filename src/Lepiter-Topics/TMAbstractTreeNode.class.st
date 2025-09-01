"
I am an abstract parent for trees of Topic Map nodes representing pages, topics, fields, and styles.

I support navigation via dedicated views of page groups.
"
Class {
	#name : #TMAbstractTreeNode,
	#superclass : #Object,
	#instVars : [
		'topicMap',
		'treeMapParent'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #comparing }
TMAbstractTreeNode >> = other [
	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [^ false ].
	^ self name = other name
]

{ #category : #navigation }
TMAbstractTreeNode >> allChildren [
	| allChildren |
	allChildren := OrderedCollection withAll: self children.
	self children do: [ :each | allChildren addAll: each allChildren ].
	^ allChildren
]

{ #category : #navigation }
TMAbstractTreeNode >> children [
	self subclassResponsibility
]

{ #category : #navigation }
TMAbstractTreeNode >> database [
	^ self topicMap database
]

{ #category : #navigation }
TMAbstractTreeNode >> databaseNode [
	^ self topicMap databaseNode
]

{ #category : #navigation }
TMAbstractTreeNode >> fieldNodes [
	^ TMNodeGroup
		for: (self fields collect: [ :aField | TMFieldNode for: aField in: self topicMap ])
		in: self topicMap
]

{ #category : #accessing }
TMAbstractTreeNode >> fields [
	self subclassResponsibility
]

{ #category : #actions }
TMAbstractTreeNode >> gtPageGroupActionFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Inspect pages';
		priority: 30;
		icon: BrGlamorousVectorIcons changes;
		action: [ :aButton | aButton phlow spawnObject: self pageGroup ];
		primaryModifierAction: [ :aButton | aButton phlow showObject: self pageGroup ]
			mouseCursor: BlCopyCursor new
]

{ #category : #actions }
TMAbstractTreeNode >> gtSpawnTopicMapActionFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Topic map';
		priority: 35;
		icon: TopicMap topicMapIcon;
		action: [ :aButton | aButton phlow spawnObject: self topicMap ];
		primaryModifierAction: [ :aButton | aButton phlow showObject: self topicMap ]
			mouseCursor: BlCopyCursor new
]

{ #category : #searching }
TMAbstractTreeNode >> gtSpotterForPageContent: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page content';
		priority: 25;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #asMarkdownPage;
		sendCategory: [ :aCategory :aStep :thisSearch | TMPageGroup for: self topicMap with: aCategory items contents ];
		filterBySubstring
]

{ #category : #searching }
TMAbstractTreeNode >> gtSpotterForPageTitles: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Page titles';
		priority: 20;
		items: [ self pages ];
		itemsLimit: Float infinity;
		itemName: #title;
		sendCategory: [ :aCategory :aStep :thisSearch | TMPageGroup for: self topicMap with: aCategory items contents ];
		filterBySubstring
]

{ #category : #views }
TMAbstractTreeNode >> gtSummaryFor: aView [
	<gtView>
	"self summary ifEmpty: [ ^ aView empty ]."
	^ aView columnedList
		title: 'Summary';
		priority: 20;
		items: [ self summary ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Key'
			text: #first
			width: 100;
		column: 'Value' text: #second;
		send: #last
]

{ #category : #views }
TMAbstractTreeNode >> gtTreeFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Topic Map';
		priority: 10;
		items: [ self children];
		children: #children;
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Node'
			text: [ :each | each name ]
			width: 300;
		column: '# Children'
			text: [ :each | each children size ]
			width: 100;
		column: '# Pages'
			text: [ :each | each pages size ]
			width: 100;
		column: '# Styles'
			text: [ :each | each styles size ]
			width: 100;
		column: 'Info'
			text: [ :each | each relatedInfo ]
			width: 300;
		send: [ :each | each ];
		actionUpdateButton
]

{ #category : #views }
TMAbstractTreeNode >> gtTreeMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Tree Map';
		priority: 30;
		object: [ self treeMap ];
		view: #gtLiveFor:;
		actionUpdateButton
]

{ #category : #comparing }
TMAbstractTreeNode >> hash [
	^ self name hash
]

{ #category : #testing }
TMAbstractTreeNode >> isAbstract [
	^ self == TMAbstractTreeNode
]

{ #category : #accessing }
TMAbstractTreeNode >> name [
	self subclassResponsibility
]

{ #category : #navigation }
TMAbstractTreeNode >> pageGroup [
	^ TMPageGroup for: self topicMap with: self pages
]

{ #category : #navigation }
TMAbstractTreeNode >> pageNodes [
	self
		deprecated: 'Use pageGroup instead'
		transformWith: '`@receiver pageNodes' -> '`@receiver pageGroup'.
	^ self pageGroup
]

{ #category : #navigation }
TMAbstractTreeNode >> pages [
	self subclassResponsibility
]

{ #category : #printing }
TMAbstractTreeNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
TMAbstractTreeNode >> relatedInfo [
	"Related information to display."

	^ '-'
]

{ #category : #utility }
TMAbstractTreeNode >> sizeAndFirstIfAlone: aCollection [
	^ aCollection size printString
		, (aCollection size = 1 ifTrue: [ ' — ' , aCollection first ] ifFalse: [ '' ])
]

{ #category : #navigation }
TMAbstractTreeNode >> styleNodes [
	^ TMNodeGroup
		for: (self styles
				collect: [ :aStyle | 
					TMStyleNode
						for: aStyle
						in: self topicMap
						within: self pageGroup ])
		in: self topicMap
]

{ #category : #treemaps }
TMAbstractTreeNode >> stylePalette [
	^ {'Introduction' -> Color red lighter.
		'Media' -> Color green.
		'Tutorial' -> Color blue muchLighter.
		'Case study' -> Color purple.
		'Pattern' -> Color orange.
		'FAQ' -> Color paleYellow.
		'Examples' -> Color lightRed.
		'Documentation' -> Color paleBlue.
		'Definition' -> Color black.
		'Index' -> Color gray.
		'Tag' -> Color veryLightGray} asDictionary
]

{ #category : #navigation }
TMAbstractTreeNode >> styles [
	self subclassResponsibility
]

{ #category : #views }
TMAbstractTreeNode >> summary [
	^ {{'Database'.
			self database.
			self databaseNode}.
		{'#Fields'.
			self sizeAndFirstIfAlone: self fields.
			self fieldNodes}.
		{'#Topics'.
			self sizeAndFirstIfAlone: self topics.
			self topicNodes}.
		{'#Styles'.
			self sizeAndFirstIfAlone: self styles.
			self styleNodes}.
		{'#Pages'.
			self sizeAndFirstIfAlone: (self pages collect: #title).
			self pageGroup}}
]

{ #category : #navigation }
TMAbstractTreeNode >> topicMap [
	^ topicMap
]

{ #category : #navigation }
TMAbstractTreeNode >> topicMap: anObject [
	topicMap := anObject
]

{ #category : #navigation }
TMAbstractTreeNode >> topicNodes [
	^ TMNodeGroup
		for: (self topics collect: [ :aTopic | TMTopicNode for: aTopic in: self topicMap ])
		in: self topicMap
]

{ #category : #navigation }
TMAbstractTreeNode >> topics [
	self subclassResponsibility
]

{ #category : #treemaps }
TMAbstractTreeNode >> treeMap [
	| stylePalette treemap |
	stylePalette := self stylePalette.
	treemap := GtNestedRectangleTreeMap new
			roots: self treeMapRoots;
			leaves: [ :aNode | aNode treeMapLeaves ];
			deep: [ :aNode | aNode treeMapChildren ];
			leavesSize: [ :aPageNode | aPageNode page asMarkdownString size max: 1000 ];
			leafElement: [ :anElement :aLeafContext | 
				| page pageNode |
				pageNode := aLeafContext model.
				page := pageNode page.
				anElement
					background: (stylePalette at: pageNode style ifAbsent: Color veryLightGray).
				anElement
					when: BlClickEvent
					do: [ :e | e target phlow spawnObject: pageNode ].
				anElement
					aptitude: (BrGlamorousWithExplicitTooltipAptitude content: [ pageNode treeMapTooltip ]) ];
			containerElement: [ :anElement :aNodeContext | 
				| node |
				node := aNodeContext model.	"aNodeContext level = 2
					ifTrue: [ anElement
							addChild: (BrLabel new
									text: node name;
									aptitude: (BrGlamorousLabelAptitude new
											fontSize: 10;
											foreground: Color blue);
									background: Color white;
									constraintsDo: [ :c | c ignoreByLayout ]) ]."

				anElement border: (BlBorder paint: node treeMapNodeColor width: 2).
				anElement padding: (BlInsets all: 2) ].
	^ treemap
]

{ #category : #treemaps }
TMAbstractTreeNode >> treeMapChildren [
	^ self children
		collect: [ :n | 
			n
				treeMapParent: self;
				yourself ]
]

{ #category : #treemaps }
TMAbstractTreeNode >> treeMapLeaves [
	^ {}
]

{ #category : #treemaps }
TMAbstractTreeNode >> treeMapNodeColor [
	^ Color gray
]

{ #category : #treemaps }
TMAbstractTreeNode >> treeMapNodeLabel [
	^ self name
]

{ #category : #treemaps }
TMAbstractTreeNode >> treeMapParent [
	^ treeMapParent
]

{ #category : #treemaps }
TMAbstractTreeNode >> treeMapParent: aTMTreeNode [
	"NB: the parent of a TopicNode is normally a FieldNode, but it could be a PageNode."

	treeMapParent := aTMTreeNode
]

{ #category : #accessing }
TMAbstractTreeNode >> treeMapPath [
	^ (self treeMapParent
		ifNil: [ '' ]
		ifNotNil: [ self treeMapParent treeMapPath , String cr ]) , self name
]

{ #category : #treemaps }
TMAbstractTreeNode >> treeMapRoots [
	^ {self}
]

{ #category : #navigation }
TMAbstractTreeNode >> withAllChildren [
	^ {self} , self allChildren
]
