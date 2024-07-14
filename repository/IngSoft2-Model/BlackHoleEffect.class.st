"
moves ship 4 tiles back
"
Class {
	#name : 'BlackHoleEffect',
	#superclass : 'EffectOnOneShip',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
BlackHoleEffect >> affectAShip: aShip [

	aShip moveTiles: -4
]
