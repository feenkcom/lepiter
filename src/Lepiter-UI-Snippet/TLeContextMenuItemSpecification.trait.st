"
I define minimum API that Spotter candidates (items) must satisfy to work properly in the new spotter dropdown menu. 
See ${method:LeSnippetLook>>#newAddSnippetDropdown}$ where the ${method:TLeContextMenuItemSpecification>>#asSnippet|label=#selector}$ is used. 
"
Trait {
	#name : #TLeContextMenuItemSpecification,
	#category : #'Lepiter-UI-Snippet-Spotter'
}

{ #category : #'api - converting' }
TLeContextMenuItemSpecification >> asSnippet [
	<return: #LeSnippet>
	^ self explicitRequirement
]
