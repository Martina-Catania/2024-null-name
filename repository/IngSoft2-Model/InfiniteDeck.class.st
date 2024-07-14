"
infinite deck of cards
creates cards as needed following a probability
"
Class {
	#name : 'InfiniteDeck',
	#superclass : 'Object',
	#instVars : [
		'probabilityManager',
		'probabilityCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
InfiniteDeck class >> probabilityDistributionIsValid: aProbabilityDistributionCollection [

	| sum |
	sum := 0.

	aProbabilityDistributionCollection do: [ :effectProbability |
		sum := sum + effectProbability probability ].
	sum = 100 ifFalse: [
		Error signal:
			'Total card probabilities cannot be diferent from 100%' ]
]

{ #category : 'class initialization' }
InfiniteDeck class >> withCardProbabilities: aProbabilityDistributionCollection [

	self probabilityDistributionIsValid: aProbabilityDistributionCollection.
	^ self new initalizeWithCards: aProbabilityDistributionCollection.
]

{ #category : 'generating' }
InfiniteDeck >> cardAtRandom [

	^ probabilityManager elementAtRandom: probabilityCards
]

{ #category : 'initialization' }
InfiniteDeck >> initalizeWithCards: aCollectionOfProbabilities [
	
	probabilityManager := ProbabilityManager new.

	probabilityCards := probabilityManager
		                    transformIntoProbabilityRanges:
		                    aCollectionOfProbabilities.

]
