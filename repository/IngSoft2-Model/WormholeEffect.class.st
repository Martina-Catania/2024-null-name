"
moves ship to another fixed tile
"
Class {
	#name : 'WormholeEffect',
	#superclass : 'EffectOnOneShip',
	#instVars : [
		'wormholeDistance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'class initialization' }
WormholeEffect class >> fromPosition: firstPosition toPosition: lastPosition [

	^ self new
		  initializeInPosition: firstPosition
		  toPosition: lastPosition
]

{ #category : 'applying' }
WormholeEffect >> affectAShip: aShip [

	aShip moveTiles: wormholeDistance
]

{ #category : 'initialization' }
WormholeEffect >> initializeInPosition: firstPosition toPosition: lastPosition [

	wormholeDistance := lastPosition - firstPosition
]
