//#-hidden-code
//
//  main.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//
//#-end-hidden-code
/*:#localized(key: "FirstProseBlock")
 **Goal:** Modify the code to personalize your game.
 
 Look at the **SharedCode** file and read through the code to figure out how the game is set up. The code you write in `setup(game:)` will be saved and used in all pages of this book.
 
 1. Try modifying the emoji values for `game.addAction`, `game.addOpponent`, and `game.prize`.
 2. Try changing the colors for `game.myColor` or `game.backgroundColors`.
 
 When you’re ready, move on to the [next page](@next) to explore adding more actions and defining new rules for the game.
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
viewController.needAssessment = true
PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
//#-editable-code
let game = Game()

//#-localizable-zone(ex2k01)
// To modify your setup code, edit setup(game:) in the SharedCode file.
//#-end-localizable-zone
setup(game: game)

//#-localizable-zone(ex2k02)
// Example: changes the game prize to "🍩".
// To preserve this code in your game, cut and paste this line into setup(game:) in SharedCode.swift.
//#-end-localizable-zone
game.prize = "🍩"

game.play()
//#-end-editable-code
//#-hidden-code
viewController.game = game
//#-end-hidden-code


