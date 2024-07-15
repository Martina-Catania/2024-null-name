"
a
"
Class {
	#name : 'CardHandler',
	#superclass : 'Object',
	#instVars : [
		'game',
		'lastCardPlayed',
		'gameDeck',
		'coalitions',
		'discardedCards',
		'cardsInHand',
		'activePermanentCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'class initialization' }
CardHandler class >> withDeck: aDeck andGame: aGame [

	^ self new
		  initalizeWithDeck: aDeck
		  inGame: aGame
]

{ #category : 'generating' }
CardHandler >> activateCard: aCardToPlay withTarget: aTarget [

	aCardToPlay activate: self withTarget: aTarget
]

{ #category : 'accessing' }
CardHandler >> addCoalition: aCoalition [

	coalitions add: aCoalition
]

{ #category : 'comparing' }
CardHandler >> addToActiveCards: aCard [

	activePermanentCards add: aCard
]

{ #category : 'generating' }
CardHandler >> applyLastEffectOn: aTarget [

	game applyLastEffectOn: aTarget
]

{ #category : 'accessing' }
CardHandler >> cardsInHand [

	^ cardsInHand
]

{ #category : 'accessing' }
CardHandler >> changeLastCardTo: aCard [

	lastCardPlayed := aCard
]

{ #category : 'argument validation' }
CardHandler >> checkTarget: aTarget [

	^ activePermanentCards anySatisfy: [ :card | aTarget = card ]
]

{ #category : 'generating' }
CardHandler >> deactivate: aTarget [

	aTarget objective deactivate: self.

]

{ #category : 'modifying' }
CardHandler >> giveCardTo: aShipName [

	gameDeck isEmpty ifTrue: [ self shuffleDiscarded ].
	cardsInHand add: (gameDeck cardAtRandom withHolder: aShipName)
]

{ #category : 'initialization' }
CardHandler >> initalizeWithDeck: aDeck inGame: aGame [

	gameDeck := aDeck.
	cardsInHand := OrderedCollection new.
	discardedCards := OrderedCollection new.
	activePermanentCards := OrderedCollection new.
	lastCardPlayed := NullCard new.
	game := aGame.
	coalitions := OrderedCollection new
]

{ #category : 'accessing' }
CardHandler >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : 'comparing' }
CardHandler >> mercenariesOf: aShip [

	| mercenaryCollection |

	mercenaryCollection := (coalitions select: [ :coalition |
		                        coalition hasLeader: aShip shipName ])
		                       collect: [ :coalition | coalition mercenary ].
	
	mercenaryCollection add: aShip shipName.
	^ mercenaryCollection
]

{ #category : 'modifying' }
CardHandler >> movementCardsActivated: theShipInTurn [

	| temp |
	temp := 0.
	activePermanentCards do: [ :card |
		   temp := temp + (card applyMovementOn: theShipInTurn) ].
	^ temp max: 0
]

{ #category : 'comparing' }
CardHandler >> removeCardFromShipDeck: aCard [

	cardsInHand
		remove: aCard
		ifAbsent: [ Error signal: 'Card was not found in Ship Deck' ]
]

{ #category : 'comparing' }
CardHandler >> removeCoalitionOf: aLeader and: aMercenary [

	coalitions removeAllSuchThat: [ :coalition |
		coalition = (ShipCoalition
			withLeader: aLeader
			andMercenary: aMercenary objective) ]
]

{ #category : 'comparing' }
CardHandler >> removeFromActiveCard: aTarget [

	activePermanentCards remove: aTarget
]

{ #category : 'modifying' }
CardHandler >> shuffleDiscarded [

	| cards |
	discardedCards isEmpty ifTrue: [
		Error signal: 'There are no cards right now.' ].
	
	cards := OrderedCollection new.
	1 to: discardedCards size do: [ :i |
		| aCard |
		aCard := discardedCards atRandom.
		discardedCards remove: aCard.
		cards add: aCard ].

	gameDeck := FiniteDeck withCards: cards
]

{ #category : 'comparing' }
CardHandler >> validateCard: aCard [

	cardsInHand
		detect: [ :card | card = aCard ]
		ifNone: [ CardExeption signal: 'Ship does not have that card' ]
]

{ #category : 'comparing' }
CardHandler >> verifyCoalition: mercenaryShip [

	(coalitions anySatisfy: [ :coalition |
		 coalition mercenary = mercenaryShip ]) ifTrue: [
		CardExeption signal:
			'Targeted ship is already a mercenary in another coalition' ]
]
