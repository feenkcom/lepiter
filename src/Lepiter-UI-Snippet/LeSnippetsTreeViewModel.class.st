Class {
	#name : #LeSnippetsTreeViewModel,
	#superclass : #LeSnippetsCollectionViewModel,
	#category : 'Lepiter-UI-Snippet-! View Models'
}

{ #category : #private }
LeSnippetsTreeViewModel >> createChildrenUIModelsOf: aLeContentUIModel [
	aLeContentUIModel snippetChildren: (aLeContentUIModel snippetModel children collect: [ :eachChildContent | self findOrCreateSnippetViewModel: eachChildContent ]).
	aLeContentUIModel snippetChildren do: [ :eachLeContentUIModel | self createChildrenUIModelsOf: eachLeContentUIModel ]
]

{ #category : #private }
LeSnippetsTreeViewModel >> updateChildren [
	"This rebuilds the tree of UI models according to the current content while trying to reuse the existing UI models"

	children := (LeChildrenSelector default rootsFor: self content)
		collect: [ :eachRootSnippet | self findOrCreateSnippetViewModel: eachRootSnippet ].

	children do: [ :eachRootSnippetUIModel | self createChildrenUIModelsOf: eachRootSnippetUIModel ]
]
