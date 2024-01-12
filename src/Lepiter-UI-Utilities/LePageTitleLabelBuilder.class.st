"
I am a builder for a clickable label for a page that may or may not exist in a Lepiter database.
Useful for Mondrian maps of pages.

Examples:

```
LePageTitleLabelBuilder
		forTitle: 'Glamorous Toolkit'
		andDatabase: LeDatabase gtBook
```

```
LePageTitleLabelBuilder
		forPage: (LeDatabase gtBook pageNamed: 'Glamorous Toolkit')
```

Send `#build` to get the label.




"
Class {
	#name : #LePageTitleLabelBuilder,
	#superclass : #Object,
	#instVars : [
		'database',
		'title'
	],
	#category : #'Lepiter-UI-Utilities-Mondrian'
}

{ #category : #accessing }
LePageTitleLabelBuilder class >> forPage: aPage [
	^ self new
		title: aPage title;
		database: aPage database;
		yourself
]

{ #category : #accessing }
LePageTitleLabelBuilder class >> forTitle: aPageTitle andDatabase: aLeDatabase [
	^ self new
		title: aPageTitle;
		database: aLeDatabase;
		yourself
]

{ #category : #accessing }
LePageTitleLabelBuilder >> build [
	^ BrLabel new
		text: self title;
		aptitude: BrGlamorousLabelAptitude new bold
				+ (BrStyleCommonAptitude new
						hovered: [ :aStyle | aStyle background: self hoverColor ]);
		when: BlClickEvent
			do: [ :e | 
				self page
					ifNil: [ e target phlow spawnObject: nil ]
					ifNotNil: [ e target phlow spawnTool: self page asPhlowTool ].
				e consumed: true ];
		padding: (BlInsets all: 5)
]

{ #category : #accessing }
LePageTitleLabelBuilder >> database [
	^ database
]

{ #category : #accessing }
LePageTitleLabelBuilder >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #accessing }
LePageTitleLabelBuilder >> gtLabelFor: aView [
	<gtView>
	^ aView forward
		title: 'Label';
		priority: 10;
		object: self build;
		view: #gtLiveFor:
]

{ #category : #accessing }
LePageTitleLabelBuilder >> hoverColor [
	^ self database
		pageNamed: self title
		ifPresent: [ Color paleBlue ]
		ifAbsent: [ Color pink ]
]

{ #category : #accessing }
LePageTitleLabelBuilder >> page [
	^ self database pageNamed: self title ifAbsent: nil
]

{ #category : #accessing }
LePageTitleLabelBuilder >> title [
	^ title
]

{ #category : #accessing }
LePageTitleLabelBuilder >> title: aPageTitle [
	title := aPageTitle
]
