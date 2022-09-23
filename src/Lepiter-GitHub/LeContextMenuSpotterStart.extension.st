Extension { #name : #LeContextMenuSpotterStart }

{ #category : #'*Lepiter-GitHub' }
LeContextMenuSpotterStart >> gtSpotterForGitHubIssueUrlFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		priority: 1;
		title: 'Add GitHub issue snippet';
		itemName: #title;
		search: [ :aContext |
			((aContext searchQuery asAsyncFuture asAsyncStream
				collect: #trimBoth)
				select: [ :aQuery | LeGitHubUtility isValidGitHubIssueUrl: aQuery ])
				collect: [ :aQuery |
					(LeContextMenuItemValuableSpecification new
						valuable: [ LeGitHubIssueSnippet new url: aQuery ];
						title: [ LeGitHubUtility shortGitHubIssueNameFromUrl: aQuery ]) ] ]
]
