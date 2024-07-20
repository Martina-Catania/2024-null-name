"
cancel an active permanent card
"
Class {
	#name : 'CancellationCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'event' }
CancellationCard >> activate: aCardHandler withTarget: aCard [

	super activate: aCardHandler withTarget: aCard.
	aCardHandler removeFromActiveCards: target objective.
]
