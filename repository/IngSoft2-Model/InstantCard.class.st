"
superclass for instant cards
redo is here since it can be activated at any time, not just the holder's turn
"
Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'event' }
InstantCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
	aCardHandler changeLastCardTo: self.
	aCardHandler discard: self.
]

{ #category : 'comparing' }
InstantCard >> canPlayRightNow: theShipInTurn [

	^ true
]
