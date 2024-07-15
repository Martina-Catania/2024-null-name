"
duplicates target ship's dice throw during their next battle
"
Class {
	#name : 'DoubleCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'event' }
DoubleCard >> activate: aCardHandler withTarget: aShip [

	super activate: aCardHandler withTarget: aShip.
	aCardHandler addToActiveCards: self.
]
