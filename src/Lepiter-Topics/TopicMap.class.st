Class {
	#name : #TopicMap,
	#superclass : #Object,
	#instVars : [
		'jsonFile',
		'json',
		'database',
		'page2Topics',
		'page2Category'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TopicMap class >> forJson: aFileReference [
	^ self new
		jsonFile: aFileReference;
		yourself
]

{ #category : #accessing }
TopicMap >> categories [
	^ self json at: 'categories'
]

{ #category : #accessing }
TopicMap >> category2Page [
	| dict |
	dict := Dictionary new.
	self page2Category
		associationsDo: [ :assoc | (dict at: assoc value ifAbsentPut: OrderedCollection new) add: assoc key ].
	^ dict
]

{ #category : #utility }
TopicMap >> clearCaches [
	"If we update the json and write it out, we need to clear the caches so they will be updated too."

	database := nil.
	page2Topics := nil.
	page2Category := nil
]

{ #category : #accessing }
TopicMap >> database [
	^ database
		ifNil: [ database := LeDatabase databaseNamed: (self json at: 'database') ]
]

{ #category : #views }
TopicMap >> gtCategoriesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Categories';
		priority: 20;
		items: [ self categories ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Count'
			text: [ :cat | (self category2Page at: cat) size ]
			width: 50;
		column: 'Item' text: [ :eachItem | eachItem gtDisplayText ];
		send: [ :cat | self category2Page at: cat ];
		actionUpdateButton
]

{ #category : #views }
TopicMap >> gtCategoryMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Page to Category map';
		priority: 22;
		object: [ self page2Category ];
		view: #gtItemsFor:;
		send: [ :assoc | assoc key ];
		actionUpdateButton
]

{ #category : #views }
TopicMap >> gtJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON';
		priority: 10;
		object: [ self json ];
		view: #gtTreeFor:context:
]

{ #category : #accessing }
TopicMap >> json [
	^ json ifNil: [ json := STONJSON fromString: self jsonFile contents ]
]

{ #category : #accessing }
TopicMap >> jsonFile [
	^ jsonFile
]

{ #category : #accessing }
TopicMap >> jsonFile: aFileReference [
	jsonFile := aFileReference
]

{ #category : #querying }
TopicMap >> missingPages [
	"Pages listed in the JSON but not (or no longer) in the database."

	^ (self json at: 'pages')
		collect: [ :d | d at: 'page' ]
		thenReject: [ :p | self database hasPageNamed: p ]
]

{ #category : #mapping }
TopicMap >> page2Category [
	^ page2Category
		ifNil: [ page2Category := ((self json at: 'pages')
					select: [ :d | self database hasPageNamed: (d at: 'page') ]
					thenCollect: [ :d | (self database pageNamed: (d at: 'page')) -> (d at: 'category') ])
					asDictionary ]
]

{ #category : #mapping }
TopicMap >> page2Topics [
	^ page2Topics
		ifNil: [ page2Topics := ((self json at: 'pages')
					select: [ :d | self database hasPageNamed: (d at: 'page') ]
					thenCollect: [ :d | (self database pageNamed: (d at: 'page')) -> (d at: 'topics') ])
					asDictionary ]
]

{ #category : #querying }
TopicMap >> pages [
	^ self page2Topics keys
]
