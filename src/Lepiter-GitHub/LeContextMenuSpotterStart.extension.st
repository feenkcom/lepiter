Extension { #name : 'LeContextMenuSpotterStart' }

{ #category : '*Lepiter-GitHub' }
LeContextMenuSpotterStart >> gtSpotterForGitHubIssueUrlFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 1;
		title: 'Add GitHub issue snippet';
		itemName: #title;
		filter: GtNullFilter
			item: [ :filter :context | 
				(LeGitHubUtility isValidGitHubIssueUrl: context textTrimmed)
					ifTrue: [ filter value: (LeContextMenuItemValuableSpecification new
						valuable: [ LeGitHubIssueSnippet new url: context textTrimmed ];
						title: [ LeGitHubUtility shortGitHubIssueNameFromUrl: context textTrimmed asString ]) ] ];
		wantsToDisplayOnEmptyQuery: false
]
