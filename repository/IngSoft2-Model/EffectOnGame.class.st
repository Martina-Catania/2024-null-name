"
superclass for all effects that only interact with game
leaves system open for extension (ex: an effect that allows a player to play their turn again should be created here)
"
Class {
	#name : 'EffectOnGame',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
EffectOnGame >> applyOn: aGame activatedBy: aShip [

	self subclassResponsibility.
]
