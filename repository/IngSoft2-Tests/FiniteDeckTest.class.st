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
