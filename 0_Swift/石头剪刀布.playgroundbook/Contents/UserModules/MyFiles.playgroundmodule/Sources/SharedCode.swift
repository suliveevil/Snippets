//  /*#-localizable-zone(SharedCodeCopyright1)*/Copyright/*#-end-localizable-zone*/ © 2016-2019 Apple Inc. /*#-localizable-zone(SharedCodeCopyright2)*/All rights reserved./*#-end-localizable-zone*/

//#-localizable-zone(RockPaperScissors01)
// Shared Code
// Code written in this file is available on all pages in this Playground Book.
//#-end-localizable-zone

//#-localizable-zone(RockPaperScissors02)
// Sets up your Rock, Paper, Scissors, game.
//#-end-localizable-zone
public func setup(game: Game) {
//#-localizable-zone(RockPaperScissors03)
    // Actions for the game.
//#-end-localizable-zone
    let rock = game.addAction("✊")
    let paper = game.addAction("🖐")
    let scissors = game.addAction("✌️")
    
//#-localizable-zone(RockPaperScissors04)
    // Rules for the actions.
//#-end-localizable-zone
    rock.beats(scissors)
    scissors.beats(paper)
    paper.beats(rock)
    
//#-localizable-zone(RockPaperScissors05)
    // Opponents for the game.
//#-end-localizable-zone
    game.addOpponent("🤖", color: #colorLiteral(red: 0.8, green: 0, blue: 0.3882352941, alpha: 1))
    
//#-localizable-zone(RockPaperScissors06)
    // Configurations for the game.
//#-end-localizable-zone
    game.roundsToWin = 3
    
//#-localizable-zone(RockPaperScissors07)
    // Colors for the game.
//#-end-localizable-zone
    game.myColor = #colorLiteral(red: 0, green: 0.6392156863, blue: 0.8509803922, alpha: 1)
    game.outerRingColor = #colorLiteral(red: 0.7450980392, green: 0.8352941176, blue: 0.8980392157, alpha: 1)
    game.innerCircleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    game.mainButtonColor = #colorLiteral(red: 0, green: 0.6392156863, blue: 0.8509803922, alpha: 1)
    game.changeActionButtonsColor = #colorLiteral(red: 0.4546349278, green: 0.6598061836, blue: 0.8290498719, alpha: 1)
    game.backgroundColors = [#colorLiteral(red: 0.7843137255, green: 0.9058823529, blue: 1, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.9843137255, blue: 1, alpha: 1)]
}
