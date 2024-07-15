Class {
	#name : 'FiniteDeckTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
FiniteDeckTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
FiniteDeckTest >> testFiniteDeckCannotHaveLessThanOneCard [

	| aDeckCreator |
	aDeckCreator := CardDeckCreator createWithProbabilityDistribution:
		                (OrderedCollection with: (ProbabilityAssociation
				                  associate: CancellationCard
				                  withProbability: 100)).
	self
		should: [
			FiniteDeck withCards:
				(aDeckCreator generateDeckWithAmountOfCards: 0) ]
		raise: Error
		withMessage: 'Deck muct have at least one card.'
]

{ #category : 'tests' }
FiniteDeckTest >> testIfThereAreNoMoreCardsInDeckAndNoDiscardedCardsThenShipCannotDrawCard [

	| aDeck aDeckCreator aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray |
	aTileArray := OrderedCollection new.

	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 4 put: CardGeneratorEffect new.
	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aDeckCreator := CardDeckCreator createWithProbabilityDistribution:
		                (OrderedCollection with:
			                 (ProbabilityAssociation
				                  associate: NullCard
				                  withProbability: 100)).
	aDeck := FiniteDeck withCards:
		         (aDeckCreator generateDeckWithAmountOfCards: 4).

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	self
		should: [ aGame playTurn ]
		raise: Error
		withMessage: 'There are no cards right now.'
]

{ #category : 'tests' }
FiniteDeckTest >> testWhenCardsAreTakenOutOfFiniteDeckItsSizeDecreases [

	| aDeck aDeckCreator aCollectionOfCards |
	aCollectionOfCards := OrderedCollection new.
	aDeckCreator := CardDeckCreator createWithProbabilityDistribution:
		                (OrderedCollection with: (ProbabilityAssociation
				                  associate: CancellationCard
				                  withProbability: 100)).
	aDeck := FiniteDeck withCards:
		         (aDeckCreator generateDeckWithAmountOfCards: 15).
	10 timesRepeat: [ aCollectionOfCards add: aDeck cardAtRandom ].

	self assert:
		(aCollectionOfCards allSatisfy: [ :card | card = CancellationCard ]).
	self assert: aDeck deckSize equals: 5
]

{ #category : 'tests' }
FiniteDeckTest >> testWhenFiniteDeckIsCreatedItHasASetAmountOfCards [

	| aDeck aDeckCreator |
	aDeckCreator := CardDeckCreator createWithProbabilityDistribution:
		                (OrderedCollection with: (ProbabilityAssociation
				                  associate: CancellationCard
				                  withProbability: 100)).
	aDeck := FiniteDeck withCards:
		         (aDeckCreator generateDeckWithAmountOfCards: 5).
	self assert: aDeck deckSize equals: 5
]
