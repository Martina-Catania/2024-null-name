"
moves ship 4 tiles forward but makes them lose a shield
"
Class {
	#name : 'HyperSpaceJumpEffect',
	#superclass : 'EffectOnOneShip',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
HyperSpaceJumpEffect >> affectAShip: aShip [
	
	aShip moveTiles: 4.
	aShip loseOneShield.
]
