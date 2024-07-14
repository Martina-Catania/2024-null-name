"
finite deck of cards, created with an array of cards
"
Class {
	#name : 'FiniteDeck',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'size'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'class initialization' }
FiniteDeck class >> amountOfCardsIsValid: anAmountOfCards [

	anAmountOfCards strictlyPositive ifFalse: [
		Error signal: 'Deck muct have at least one card.' ]
]

{ #category : 'class initialization' }
FiniteDeck class >> withCards: anArrayOfCards [

	self amountOfCardsIsValid: anArrayOfCards size.
	^ self new initalizeWithFiniteCards: anArrayOfCards
]

{ #category : 'accessing' }
FiniteDeck >> deckSize [
	^size
]

{ #category : 'initialization' }
FiniteDeck >> initalizeWithFiniteCards: aCardCollection [ 
	cards := aCardCollection.
	size := aCardCollection size.
]
