"
moves ship a variable amount of parsecs
can move ship forwards or backwards
"
Class {
	#name : 'HyperJumpEffect',
	#superclass : 'EffectOnOneShip',
	#instVars : [
		'parsecCollection',
		'parsecNumber',
		'boardParsecToTileRatio'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'class initialization' }
HyperJumpEffect class >> withParsecArray: aParsecArray andLengthInTiles: lengthInTiles andLengthInParsecs: lengthInParsecs [

	^ self new
		  initializeWithParsecArray: aParsecArray
		  andLengthInTiles: lengthInTiles
		  andLengthInParsecs: lengthInParsecs
]

{ #category : 'applying' }
HyperJumpEffect >> affectAShip: aShip [

	aShip moveTiles:
		((parsecCollection at: self currentParsec) toUnit: Parsec)
			nominalValue asInteger * boardParsecToTileRatio
]

{ #category : 'modifying' }
HyperJumpEffect >> currentParsec [

	parsecNumber := parsecNumber < parsecCollection size
		                ifTrue: [ parsecNumber + 1 ]
		                ifFalse: [ 1 ].
	^ parsecNumber
]

{ #category : 'generators' }
HyperJumpEffect >> generateParameters: aTileEffectCreator [

	aTileEffectCreator generateHyperJumpParameters: self
]

{ #category : 'initialization' }
HyperJumpEffect >> initializeWithParsecArray: aParsecArray andLengthInTiles: lengthInTiles andLengthInParsecs: lengthInParsecs [

	parsecCollection := aParsecArray asSortedCollection: [ :a :b | a > b ].

	boardParsecToTileRatio := lengthInTiles // lengthInParsecs.
	parsecNumber := 0
]
