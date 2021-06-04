"
It may happen that an exported [Roam JSON database](https://roamresearch.com/#/app/help/page/RxZF78p60) may have unitialized {{gtClass:LePage}} and {{gtClass:LeSnippet}} values. Particullarly, the create and edit time and email values.

I ensure that the model have expected values.
I am used by {{gtClass:LeRoamJsonTranslator}}.
## Examples
### Missing Edit Values
{{gtExample:LeRoamJsonExamples>>#databaseWithOnePageNoEditValues|noCode}}

is purified as: 

{{gtExample:LeRoamJsonExamples>>#pageNoEditValues|noCode}}

### Missing Create Values
{{gtExample:LeRoamJsonExamples>>#databaseWithOnePageNoCreateValues|noCode}}

is purified as: 

{{gtExample:LeRoamJsonExamples>>#pageNoCreateValues|noCode}}


"
Class {
	#name : #LeRoamJsonPurificator,
	#superclass : #Object,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Translator-Roam-Core'
}

{ #category : #'api - accessing' }
LeRoamJsonPurificator >> database [
	^ database
]

{ #category : #'api - accessing' }
LeRoamJsonPurificator >> database: anObject [
	database := anObject
]

{ #category : #'private - enumeration' }
LeRoamJsonPurificator >> pagesDo: aBlock [
	self database do: aBlock
]

{ #category : #'api - purification' }
LeRoamJsonPurificator >> purify [
	self pagesDo: [ :aPage | self purifyPage: aPage ].
]

{ #category : #'private - purification' }
LeRoamJsonPurificator >> purifyBlock: aBlock [
	self purifyCreateValues: aBlock.
	self purifyEditValues: aBlock.
	aBlock children do: [ :aSubBlock | self purifyBlock: aSubBlock ]
]

{ #category : #'private - purification' }
LeRoamJsonPurificator >> purifyCreateValues: aPageOrBlock [
	aPageOrBlock createTime ifNil: [ aPageOrBlock createTime: aPageOrBlock editTime ].
	aPageOrBlock createEmail ifNil: [ aPageOrBlock createEmail: aPageOrBlock editEmail ].
	
]

{ #category : #'private - purification' }
LeRoamJsonPurificator >> purifyEditValues: aPageOrBlock [
	aPageOrBlock editTime ifNil: [ aPageOrBlock editTime: aPageOrBlock createTime ].
	aPageOrBlock editEmail ifNil: [ aPageOrBlock editEmail: aPageOrBlock createEmail ].
	
]

{ #category : #'private - purification' }
LeRoamJsonPurificator >> purifyPage: aPage [
	self purifyCreateValues: aPage.
	self purifyEditValues: aPage.
	aPage children do: [ :aBlock | self purifyBlock: aBlock ]
]
