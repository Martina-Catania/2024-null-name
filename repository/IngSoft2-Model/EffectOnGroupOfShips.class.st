"
superclass for effects that apply on a group of ships, excluding some
leaves system open for extension
"
Class {
	#name : 'EffectOnGroupOfShips',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
EffectOnGroupOfShips >> affectAllShips: aCollection but: aShip [

	^ self subclassResponsibility
]

{ #category : 'applying' }
EffectOnGroupOfShips >> applyOn: aGame activatedBy: aShip [

	aGame applyEffectOnAllShipsButOne: self triggeredBy: aShip.
]
