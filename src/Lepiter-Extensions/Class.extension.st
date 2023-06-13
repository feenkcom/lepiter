Extension { #name : #Class }

{ #category : #'*Lepiter-Extensions' }
Class >> gtLepiterCommentFor: aView [
	<gtView>
	^ aView explicit
		title: 'Comment';
		priority: -1;
		disableAsync;
		stencil: [ LeCoderCommentElement coderElementFor: self name ];
		actionButtonIcon: BrGlamorousVectorIcons accept 
			tooltip: 'Save Comment' 
			action: [ :aToggle :aTab | LePharoClassDatabase uniqueInstance 
				savePage: aTab viewContentElement page ];
		actionUpdateButtonTooltip: 'Update class comment'
]
