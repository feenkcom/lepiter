Extension { #name : 'Behavior' }

{ #category : '*Lepiter-Core' }
Behavior >> gtCoderLepiterCommentsFor: aView [
	<gtClassView>

	^ aView explicit
		title: 'Comment';
		tooltip: 'Lepiter Class comment';
		priority: 30;
		disableAsync;
		stencil: [ LeCoderCommentElement coderElementFor: self name ];
		actionButtonIcon: BrGlamorousVectorIcons accept 
			tooltip: 'Save document' 
			action: [ :aToggle :aTab | LePharoClassDatabase uniqueInstance savePage: aTab viewContentElement page ];
		actionUpdateButtonTooltip: 'Update class comment'
]
