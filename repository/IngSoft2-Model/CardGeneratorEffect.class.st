"
makes game add a card to the triggering ship's hand
"
Class {
	#name : 'CardGeneratorEffect',
	#superclass : 'EffectOnGame',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
CardGeneratorEffect >> applyOn: aGame activatedBy: aShip [

	aGame giveCardToCurrentShip: aShip
]
