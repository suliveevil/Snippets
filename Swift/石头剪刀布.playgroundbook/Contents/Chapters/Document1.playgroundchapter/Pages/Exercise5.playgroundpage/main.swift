//#-hidden-code
//
//  main.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//
//#-end-hidden-code
/*:#localized(key: "FirstProseBlock")
 **Goal:** Add more opponents.

 You can play against up to four opponents. To add new opponents to the game, call `addOpponent` on the `game` object.
 
 To win a round with more than two players, a player must beat at least one other player and not lose to any others.
 
 Try adding three more opponents to the game.
 
 **Play:** Experiment with modifying the actions and rules to see how the game changes with more opponents.
 
 When you're ready, move on to the [next page](@next) to see an example of the setup game function.
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-code-completion(module, show, MyFiles, Book)
//#-code-completion(literal, show, array, boolean, color, integer, string)
//#-code-completion(identifier, show, if, for, while, func, var, let, ., =, (, ))
//#-code-completion(identifier, hide, GameViewController, viewController, GameResult, Game, Action, canPlay, Play())
import CoreGraphics
import PlaygroundSupport

let viewController = GameViewController.makeFromStoryboard()
PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
//#-editable-code
let game = Game()

setup(game: game)

//#-localizable-zone(ex5k01)
// Example: Adds an additional opponent to the game.
// Add this code to setup(game:) to use it across all pages.
//#-end-localizable-zone
game.addOpponent("🧚🏽‍♀️", color: #colorLiteral(red: 0.8, green: 0, blue: 0.3882352941, alpha: 1))

game.play()



//#-end-editable-code
//#-hidden-code
viewController.game = game
//#-end-hidden-code
