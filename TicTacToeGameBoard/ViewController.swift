//
//  ViewController.swift
//  TicTacToeGameBoard
//
//  Created by Jonas Backas on 2022-12-06.
//


import UIKit



class ViewController: UIViewController {
    
    //connections to storyboard for all the grid spots and playerlabel
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    @IBOutlet weak var topRow1: UIButton!
    
    @IBOutlet weak var topRow2: UIButton!
    
    @IBOutlet weak var topRow3: UIButton!
    
    @IBOutlet weak var middleRow1: UIButton!
    
    @IBOutlet weak var middleRow2: UIButton!
    
    @IBOutlet weak var middleRow3: UIButton!
    
    @IBOutlet weak var bottomRow1: UIButton!
    
    @IBOutlet weak var bottomRow2: UIButton!
    
    @IBOutlet weak var bottomRow3: UIButton!
    
    //declarations
    var firstTurn = String()
    var currentPlayer = true
    var nought = "O"
    var cross = "X"
    var gameboard = [UIButton]() // array of all the buttons
    var noughtScore = 0
    var crossScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGameBoard()
        
    }

    // button action,connection to the gameboard, and checking for who won then adds score to the alertview
    @IBAction func boardTapButton(_ sender: UIButton) {
        addToBoard(sender)
        if checkWhoWins(cross) {
            crossScore += 1
            resultViewAlert(title: "Crosses Win!")
        }
        if checkWhoWins(nought) {
            noughtScore += 1
            resultViewAlert(title: "Noughts Win!")
        }
        if(myGameBoard()) {
            resultViewAlert(title: "Draw")
        }
        
    }
        
        func initGameBoard() {
        gameboard.append(topRow1)
        gameboard.append(topRow2)
        gameboard.append(topRow3)
        gameboard.append(middleRow1)
        gameboard.append(middleRow2)
        gameboard.append(middleRow3)
        gameboard.append(bottomRow1)
        gameboard.append(bottomRow2)
        gameboard.append(bottomRow3)
        
    }
    
    // checking if there is an empty space on our gameboard
    func myGameBoard() -> Bool {
        for button in gameboard {
            if button.title(for: .normal) == nil {
                return false
            }
            
        }
        return true
    }
    
    //adding nought or cross to the gameboard to every gridspot of 9 grid slots.
    func addToBoard(_ sender: UIButton) {
        if(sender.title(for: .normal) == nil) {
            if(currentPlayer == true) {
                sender.setTitle(nought, for: .normal)
                currentPlayer = false
                playerTurnLabel.text = cross
                
            } else if(currentPlayer == false) {
                sender.setTitle(cross, for: .normal)
                currentPlayer = true
                playerTurnLabel.text = nought
                }
            sender.isEnabled = true // remove a animation for button that has already a nought or cross placed.
            }
        }
       
    // resultViewAlert, alert with score, to reset game,
    func resultViewAlert(title: String) {
        
        let alertMessage = "\nNoughts " + String(noughtScore) + "\n\nCrosses " + String(crossScore)

        let result = UIAlertController(title: title, message: alertMessage, preferredStyle: .actionSheet)
        result.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetGameBoard()
        }))

        self.present(result, animated: true)
    }
    
    
    //function to reset the gameboard
    func resetGameBoard() {
        for button in gameboard {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if currentPlayer == true {
            firstTurn = cross
            playerTurnLabel.text = cross
        }
        else if currentPlayer == false {
            firstTurn = nought
            playerTurnLabel.text = nought
        }
       currentPlayer = true
    }
    
    
    //function for checking if you've won, in all possible directions for 3 in row.
    func checkWhoWins(_ Check : String) -> Bool {
        
            //Horizontal Victory Check
        if gameMarker(topRow1,Check) && gameMarker(topRow2,Check) && gameMarker(topRow3,Check){
        return true
        }
        if gameMarker(middleRow1,Check) && gameMarker(middleRow2,Check) && gameMarker(middleRow3,Check){
        return true
        }
        if gameMarker(bottomRow1,Check) && gameMarker(bottomRow2,Check) && gameMarker(bottomRow3,Check){
        return true
        }
            
            //Vertical Victory Check
        if gameMarker(topRow1,Check) && gameMarker(middleRow1,Check) && gameMarker(bottomRow1,Check){
        return true
        }
        if gameMarker(topRow2,Check) && gameMarker(middleRow2,Check) && gameMarker(bottomRow2,Check){
        return true
        }
        if gameMarker(topRow3,Check) && gameMarker(middleRow3,Check) && gameMarker(bottomRow3,Check){
        return true
        }
            
            //Diagonal Victory Check
        if gameMarker(topRow1,Check) && gameMarker(middleRow2,Check) && gameMarker(bottomRow3,Check){
        return true
        }
        if gameMarker(topRow3,Check) && gameMarker(middleRow2,Check) && gameMarker(bottomRow1,Check){
        return true
    }
            
        return false
    }
    
        //function to get a symbol to use for checkWhoWon function.
        func gameMarker(_ button: UIButton, _ symbol: String) -> Bool {
    
        return button.title(for: .normal) == symbol
    }
    
    
    
}
    
    
    
    


