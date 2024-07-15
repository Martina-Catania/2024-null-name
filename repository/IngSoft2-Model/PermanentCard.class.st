"
superclass for permanent cards
"
Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
PermanentCard class >> isAbstract [

	^ self == PermanentCard
]

{ #category : 'event' }
PermanentCard >> activate: aCardHandler withTarget: aTarget [
	
	target := aTarget.
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self.
]

{ #category : 'comparing' }
PermanentCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]
