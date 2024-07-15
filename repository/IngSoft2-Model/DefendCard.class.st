Class {
	#name : 'DefendCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'event' }
DefendCard >> activate: aCardHandler withTarget: aShipName [
	
	aCardHandler addShieldTo: aShipName objective.
	target := aShipName.
	aCardHandler changeLastCardTo: self.
]

{ #category : 'comparing' }
DefendCard >> canPlayRightNow: theShipInTurn [

	^ true
]
