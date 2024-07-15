"
replay last played card (can use a new target)
"
Class {
	#name : 'RedoCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'event' }
RedoCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
	aCardHandler
		activateCard: (aCardHandler lastCardPlayed class withHolder: holder)
		withTarget: aTarget.
	aCardHandler discard: self
]
