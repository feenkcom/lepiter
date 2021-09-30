Class {
	#name : #LeTweetRefLinkReference,
	#superclass : #LeLinkExternalUrlReference,
	#category : 'Lepiter-Core-Twitter'
}

{ #category : #accessing }
LeTweetRefLinkReference class >> leJsonV3Name [

	^ 'tweetReference'
]

{ #category : #accessing }
LeTweetRefLinkReference class >> leJsonV4Name [

	^ 'tweetReference'
]

{ #category : #accessing }
LeTweetRefLinkReference >> description [
	^ 'Tweet Reference: ', (self url asString ifNil: [ String empty ])
]

{ #category : #'as yet unclassified' }
LeTweetRefLinkReference >> gtLiveFor: aView [
	<gtView>
	self url ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ 
			| aContainer anViewElement |
			aContainer := BrVerticalPane new
				margin: (BlInsets all: 10);
				hMatchParent;
				vFitContent.
			anViewElement := LeTweetRefViewElement new.
			anViewElement
				hMatchParent;
				vFitContent;
				enqueueTask: (BlTaskAction new action: [ 
					LeTweetRefClient default
						onResponse: [ :aResponse | 
							anViewElement enqueueTask: (BlTaskAction new action: [
								aResponse isSuccess 
									ifTrue: [ anViewElement tweet: aResponse tweet ]
									ifFalse: [ aContainer addChild: (BrLabel new
										aptitude: BrGlamorousLabelAptitude new;
										text: aResponse userMessage) ] ]) ];
						tweetUrl: self url ]).
			aContainer addChild: anViewElement ]
]

{ #category : #testing }
LeTweetRefLinkReference >> isExternalTweetReference [
	^ true
]
