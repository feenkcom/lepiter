"
I am responsible for mapping Lepiter database pages to their topics and styles.

I am initialized from a JSON file that contains this mapping, as well as the list of fields grouping the various topics.

"
Class {
	#name : #TopicMap,
	#superclass : #Object,
	#instVars : [
		'jsonFile',
		'json',
		'database',
		'page2Topics',
		'page2Style',
		'topic2Pages'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TopicMap class >> forJson: aFileReference [
	^ self new
		jsonFile: aFileReference;
		yourself
]

{ #category : #utility }
TopicMap >> clearCaches [
	"If we update the json and write it out, we need to clear the caches so they will be updated too."

	database := nil.
	page2Topics := nil.
	page2Style := nil.
	topic2Pages := nil
]

{ #category : #accessing }
TopicMap >> database [
	^ database
		ifNil: [ database := LeDatabase databaseNamed: (self json at: 'database') ]
]

{ #category : #accessing }
TopicMap >> fields2Topics [
	^ ((self json at: 'fields')
		collect: [ :d | (d at: 'field') -> (d at: 'topics') ]) asDictionary
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

{ #category : #views }
TopicMap >> gtStyleMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Page to Style map';
		priority: 22;
		object: [ self page2Style ];
		view: #gtItemsFor:;
		send: [ :assoc | assoc key ];
		actionUpdateButton
]

{ #category : #views }
TopicMap >> gtStylesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Styles';
		priority: 20;
		items: [ self styles ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Count'
			text: [ :cat | (self style2Pages at: cat) size ]
			width: 50;
		column: 'Item' text: [ :eachItem | eachItem gtDisplayText ];
		send: [ :cat | self style2Pages at: cat ];
		actionUpdateButton
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
TopicMap >> page2Style [
	^ page2Style
		ifNil: [ page2Style := ((self json at: 'pages')
					select: [ :d | self database hasPageNamed: (d at: 'page') ]
					thenCollect: [ :d | (self database pageNamed: (d at: 'page')) -> (d at: 'style') ])
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

{ #category : #mapping }
TopicMap >> style2Pages [
	| dict |
	dict := Dictionary new.
	self page2Style
		associationsDo: [ :assoc | (dict at: assoc value ifAbsentPut: OrderedCollection new) add: assoc key ].
	^ dict
]

{ #category : #accessing }
TopicMap >> styles [
	^ self json at: 'styles'
]

{ #category : #mapping }
TopicMap >> topic2Pages [
	^ topic2Pages
		ifNil: [ topic2Pages := Dictionary new.
			self page2Topics
				associationsDo: [ :assoc | 
					assoc value
						do: [ :topic | (topic2Pages at: topic ifAbsentPut: OrderedCollection new) add: assoc key ] ].
			topic2Pages ]
]

{ #category : #mapping }
TopicMap >> topic2Styles: aTopic [
	"NB: we list the styles of pages for a topic in the same canonical order defined in TopicMap>>#styles"

	^ self styles
		select: [ :aStyle | 
			((self topic2Pages at: aTopic) collect: [ :aPage | self page2Style at: aPage ])
				includes: aStyle ]
]
