Class {
	#name : #LeReloadReason,
	#superclass : #Object,
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #'gt - extensions' }
LeReloadReason >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Reason';
			value: self}
]

{ #category : #'gt - extensions' }
LeReloadReason >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Description' text: #description weight: 2;
		send: #value
]
