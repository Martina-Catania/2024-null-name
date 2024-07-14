"
superclass for all effects that apply on all ships
system remains open for extension (ex: an effect that moves all ships forward would be implemented here)
"
Class {
	#name : 'EffectOnAllShips',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
EffectOnAllShips >> affectAShipCollection: aShipCollection [

	^ self subclassResponsibility
]

{ #category : 'applying' }
EffectOnAllShips >> applyOn: aGame activatedBy: aShip [

	aGame applyEffectOnAllShips: self
]
