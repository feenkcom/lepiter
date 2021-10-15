"
{{gtClass:LeDatabaseMerge}} merges the supplied sourceDatabase in to the targetDatabase.  The source database must be discarded after the merge.

The merge rules are:

- Pages that don't exist in the targetDatabase are simply copied in.
  - There's currently no test for block uid collisions.
- If the page already exists, copies of the blocks from the sourceDatabase are appended to the targetDatabase.
  - If a block with the same uid already exists in the target, it isn't transferred.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
## Internal Representation and Key Implementation Points.

### Instance Variables
	sourceDatabase:		<LeDatabase>
	targetDatabase:		<LeDatabase>


### Implementation Points

The typical expected use case is that the target database imported from somewhere, merged in to the target database and then discarded.  As such, the target database takes ownership of any pages and blocks and simply removes them from the source database.


"
Class {
	#name : #LeDatabaseMerge,
	#superclass : #Object,
	#instVars : [
		'sourceDatabase',
		'targetDatabase'
	],
	#category : 'Lepiter-Utilities'
}

{ #category : #building }
LeDatabaseMerge class >> merge: sourceDatabase into: targetDatabase [

	^ self new 
		sourceDatabase: sourceDatabase;
		targetDatabase: targetDatabase;
		merge.
]

{ #category : #private }
LeDatabaseMerge >> appendBlocksFromPage: sourcePage to: targetPage [
	"Append the blocks from the sourcePage to targetPage"

	sourcePage children items copy
		do: [ :aLeSnippet | 
			(targetPage includesSnippetUid: aLeSnippet uid)
				ifFalse: [ sourcePage removeSnippet: aLeSnippet.
					targetPage addSnippet: aLeSnippet ] ]
]

{ #category : #operations }
LeDatabaseMerge >> merge [ 
	"Perform the actual merge in four phases:
	1. Group pages by added and merged (adding snippets to an existing page).
	2. Add new pages.
	3. Update links, etc. in the new pages.
	4. Add snippets to existing pages.
	Phases 2 & 3 are separated out so that links to pages don't create the target page with incorrect metadata prematurely."
	| addedPages mergedPages |

	"1. Group pages by added and merged (adding snippets to an existing page)."
	addedPages := OrderedCollection new.
	mergedPages := OrderedCollection new.
	sourceDatabase pages do: [ :page |
		(targetDatabase hasPageNamed: page title)
			ifTrue: [ mergedPages add: page ]
			ifFalse: [ addedPages add: page ] ].

	"2. Add new pages."
	addedPages do: [ :page |
		self setPage: page ].
	"3. Update links, etc. in the new pages."
	addedPages do: [ :page |
		self setPageUpdate: page ].
	"4. Add snippets to existing pages."
	mergedPages do: [ :page |
		self mergePage: page ].

	^ targetDatabase
]

{ #category : #private }
LeDatabaseMerge >> mergePage: aPage [
	"Merge the snippets from the supplied page in to the target database"

	targetDatabase
		pageNamed: aPage title 
		ifPresent: [ :targetPage | self appendBlocksFromPage: aPage to: targetPage ]
		ifAbsent: [ self error: 'The target page should exist' ]
]

{ #category : #private }
LeDatabaseMerge >> setPage: aPage [
	"Add the supplied page to the target database without updating links, etc..
	The page must not already exist"

	"The page may have already been removed from the source database if it only had a single link to it"
	aPage database = sourceDatabase ifTrue:
		[ sourceDatabase removePage: aPage ].
	targetDatabase setPage: aPage.
]

{ #category : #private }
LeDatabaseMerge >> setPageUpdate: aPage [
	"Update metadata, links, etc. in the supplied page"

	targetDatabase setPageUpdate: aPage.
]

{ #category : #accessing }
LeDatabaseMerge >> sourceDatabase [
	^ sourceDatabase
]

{ #category : #accessing }
LeDatabaseMerge >> sourceDatabase: anObject [
	sourceDatabase := anObject
]

{ #category : #accessing }
LeDatabaseMerge >> targetDatabase [
	^ targetDatabase
]

{ #category : #accessing }
LeDatabaseMerge >> targetDatabase: anObject [
	targetDatabase := anObject
]
