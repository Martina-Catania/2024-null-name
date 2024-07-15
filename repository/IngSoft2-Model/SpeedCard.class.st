"
speed card class
"
Class {
	#name : 'SpeedCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'event' }
SpeedCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self.
]

{ #category : 'comparing' }
SpeedCard >> applyMovementOn: aShip [

	aShip shipName = target objective ifTrue: [ ^ 1 ].
	^ 0
]

{ #category : 'comparing' }
SpeedCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]
