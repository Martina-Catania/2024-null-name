"
s
"
Class {
	#name : 'Deck',
	#superclass : 'Object',
	#instVars : [
		'probabilityManager',
		'probabilityCards',
		'cards',
		'size'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
Deck class >> probabilityDistributionIsValid: aProbabilityDistributionCollection [

	| sum |
	sum := 0.

	aProbabilityDistributionCollection do: [ :effectProbability |
		sum := sum + effectProbability probability ].
	sum = 100 ifFalse: [
		Error signal:
			'Total card probabilities cannot be diferent from 100%' ]
]

{ #category : 'class initialization' }
Deck class >> withCardProbabilities: aProbabilityDistributionCollection [

	self probabilityDistributionIsValid: aProbabilityDistributionCollection.
	^ self new initalizeWithCards: aProbabilityDistributionCollection.
]

{ #category : 'class initialization' }
Deck class >> withCards: anArrayOfCards [ 
	^ self new initalizeWithFiniteCards: anArrayOfCards
]

{ #category : 'generating' }
Deck >> cardAtRandom [

	^ probabilityManager elementAtRandom: probabilityCards
]

{ #category : 'accessing' }
Deck >> deckSize [
	^size
]

{ #category : 'initialization' }
Deck >> initalizeWithCards: aCollectionOfProbabilities [
	
	probabilityManager := ProbabilityManager new.

	probabilityCards := probabilityManager
		                    transformIntoProbabilityRanges:
		                    aCollectionOfProbabilities.

]

{ #category : 'initialization' }
Deck >> initalizeWithFiniteCards: aCardCollection [ 
	cards := aCardCollection.
	size := aCardCollection size.
]
