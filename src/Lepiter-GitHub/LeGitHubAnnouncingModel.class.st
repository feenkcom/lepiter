Class {
	#name : #LeGitHubAnnouncingModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer'
	],
	#category : 'Lepiter-GitHub-Model'
}

{ #category : #announcer }
LeGitHubAnnouncingModel >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #initialization }
LeGitHubAnnouncingModel >> initialize [
	super initialize.
	announcer := Announcer new.
]
