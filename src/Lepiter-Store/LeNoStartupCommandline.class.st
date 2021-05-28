Class {
	#name : #LeNoStartupCommandline,
	#superclass : #CommandLineHandler,
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeNoStartupCommandline class >> commandName [
	^ 'lepiternostartup'
]

{ #category : #accessing }
LeNoStartupCommandline class >> description [

	^ 'Instruct Lepiter to not run startup actions'
]

{ #category : #activation }
LeNoStartupCommandline >> activate [

	self activateHelp ifTrue: [  ^ self ].

	Stdio stdout << 'setting no startup'; lf.
	LeLocalStoreMonitor setNoStartup.
]
