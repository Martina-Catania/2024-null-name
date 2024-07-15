"
add one shield to target ship, if it has full shields increase max shield amount
"
Class {
	#name : 'DefendCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'event' }
DefendCard >> activate: aCardHandler withTarget: aShip [
	
	super activate: aCardHandler withTarget: aShip.
	aCardHandler addShieldTo: aShip objective.
]
