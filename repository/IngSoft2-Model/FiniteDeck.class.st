"
finite deck of cards, created with an array of cards
"
Class {
	#name : 'FiniteDeck',
	#superclass : 'Object',
	#instVars : [
		'cards'
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

{ #category : 'generating' }
FiniteDeck >> cardAtRandom [

	| aCard |
	aCard := cards at: 1.
	cards remove: aCard.
	^ aCard
]

{ #category : 'accessing' }
FiniteDeck >> deckSize [

	^ cards size
]

{ #category : 'initialization' }
FiniteDeck >> initalizeWithFiniteCards: aCardCollection [

	cards := aCardCollection
]

{ #category : 'accessing' }
FiniteDeck >> isEmpty [

	^ cards isEmpty
]
