Class {
	#name : 'FiniteDeckTest',
	#superclass : 'CardsTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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
FiniteDeckTest >> testIfThereAreNoMoreCardsInDeckShuffleDiscardedCards [

	| aDeck aDeckCreator aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray aTarget |
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

	aTarget := ShipTarget withObjective: 'Juan'.
	aGame playCard: NullCard by: 'Juan' toTarget: aTarget.
	aGame playCard: NullCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.

	self assert: (aGame shipCards: 'Juan') size equals: 1.
	self assert: (aGame shipCards: 'Jose') size equals: 2
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

{ #category : 'tests' }
FiniteDeckTest >> testWhenPermanentCardIsActivatedItIsNotDiscarded [

	| aDeck aDeckCreator aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray aTarget |
	aTileArray := OrderedCollection new.

	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 6 put: CardGeneratorEffect new.
	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aDeckCreator := CardDeckCreator createWithProbabilityDistribution:
		                (OrderedCollection with:
			                 (ProbabilityAssociation
				                  associate: AccelerationCard 
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

	aTarget := ShipTarget withObjective: 'Juan'.
	aGame playCard: AccelerationCard by: 'Juan' toTarget: aTarget.
	aGame playCard: AccelerationCard by: 'Juan' toTarget: aTarget.

	self
		should: [ aGame playTurn ]
		raise: Error
		withMessage: 'There are no cards right now.'
]

{ #category : 'tests' }
FiniteDeckTest >> testWhenPermanentCardIsDeactivatedItIsDiscarded [

	| aDeck anArrayOfCards aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray aTarget anotherTarget |
	aTileArray := OrderedCollection new.

	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 4 put: CardGeneratorEffect new.
	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	anArrayOfCards := OrderedCollection new.
	2 timesRepeat: [ anArrayOfCards add: AccelerationCard ].
	2 timesRepeat: [ anArrayOfCards add: CancellationCard ].
	aDeck := FiniteDeck withCards: anArrayOfCards.

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := CardTarget withObjective:
		           (AccelerationCard withHolder: 'Juan').
		
	anotherTarget := AllShipsTarget new.
	
	aGame playCard: AccelerationCard by: 'Juan' toTarget: anotherTarget.
	aGame playCard: CancellationCard by: 'Jose' toTarget: aTarget.
	aGame playTurn.

	self assert: (aGame shipCards: 'Juan') size equals: 2.
	self assert: (aGame shipCards: 'Jose') size equals: 1
]
