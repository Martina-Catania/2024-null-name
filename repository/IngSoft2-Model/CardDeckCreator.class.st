"
a card generator for finite deck initialization
"
Class {
	#name : 'CardDeckCreator',
	#superclass : 'Object',
	#instVars : [
		'probabilityCards',
		'probabilityManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'class initialization' }
CardDeckCreator class >> createWithProbabilityDistribution: aProbabilityDistributionCollection [

	self probabilityDistributionIsValid: aProbabilityDistributionCollection.
	
	^ self new
		  initializeWithProbabilityDistribution: aProbabilityDistributionCollection
]

{ #category : 'class initialization' }
CardDeckCreator class >> probabilityDistributionIsValid: aProbabilityDistributionCollection [

	| sum |
	sum := 0.

	aProbabilityDistributionCollection do: [ :effectProbability |
		sum := sum + effectProbability probability ].
	sum = 100 ifFalse: [
		Error signal:
			'Total card probabilities cannot be diferent from 100%' ]
]

{ #category : 'generating' }
CardDeckCreator >> generateDeckWithAmountOfCards: anAmountOfCards [

	| cardArray |
	cardArray := OrderedCollection new.
	1 to: anAmountOfCards do: [ :i |
		cardArray add:
			(probabilityManager elementAtRandom: probabilityCards) ].
	^ cardArray
]

{ #category : 'initialization' }
CardDeckCreator >> initializeWithProbabilityDistribution: aProbabilityDistributionCollection [ 
	
	probabilityManager := ProbabilityManager new.

	probabilityCards := probabilityManager
		                      transformIntoProbabilityRanges:
		                      aProbabilityDistributionCollection
]
