//
//  ViewController.swift
//  Concentrate
//
//  Created by Omran Khoja on 6/28/18.
//  Copyright © 2018 AcronDesign. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
        print(cardButtons.count)
    }
    
    
    // MARK: IBOutlets
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    
    // MARK: IBActions
    
    // MARK: Handle Card Touch Behavior
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    // MARK: New Game Function
    @IBAction func createNewGame(_ sender: UIButton) {
        setupGame()
    }
    
    // MARK: Variables
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private var theme: [[String]] = []
    private var themeColorButton: UIColor = #colorLiteral(red: 0.9925357699, green: 0.6266236305, blue: 0.1708677411, alpha: 1)
    private var themeColorBackground: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    private var emojis = [Int:String]()
    private var gameEmojis = [String]()
    private var gameThemes: [String:[String]] =
        ["Animals" : ["🐶", "🐵", "🐸", "🐧", "🦊", "🦁", "🐱", "🐰", "🐻", "🐼", "🐨", "🐯"],
         "Halloween" : ["🎃", "🧞‍♀️", "🧛‍♂️", "🧝‍♀️", "🧜‍♀️", "🧟‍♂️", "😈" ,"👺", "🦇", "👽", "🤖", "👾"],
         "Sports" : ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🥅", "🏒"],
         "Food" : ["🍕", "🍔", "🌮", "🍟", "🍗", "🥩", "🍤", "🥙", "🍣", "🌭", "🍝", "🍛"],
         "Professions" : ["👩‍🍳", "👮‍♀️", "👩‍🚒", "👨‍🚀", "👨‍🔧", "👨‍⚕️", "👷‍♂️", "👩‍🌾", "👩‍🏫", "👨‍🔬", "👩‍🎨", "👩‍🏭"],
         "Faces" : ["😙", "😍", "🙃", "😋", "😇", "🤓", "😅", "😂", "☺️", "😊", "😇", "🙂"]
        ]
    
    // MARK: Functions
    private func setupRandomTheme() {
        let gameModeKeys = Array(gameThemes.keys)
        if let randomKeyIndex = gameModeKeys.randomItem(){
            gameEmojis = gameThemes[randomKeyIndex]!
            setColor(for: randomKeyIndex)
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emojis[card.identifier] == nil, gameEmojis.count > 0 {
            let randomIndex = gameEmojis.count.arc4random
            emojis[card.identifier] = gameEmojis.remove(at: randomIndex)
        }
        return emojis[card.identifier] ?? "?"
    }
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = themeColorButton
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.9246864915, green: 0.9253881574, blue: 0.9247950912, alpha: 0) : themeColorButton
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        countLabel.text = "Flips: \(game.flipCount)"
        
    }
    

    private func setupGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        setupRandomTheme()
        updateViewFromModel()
        view.backgroundColor = themeColorBackground
        for cards in cardButtons {
            cards.backgroundColor = themeColorButton
        }
        scoreLabel.backgroundColor = themeColorButton
        countLabel.backgroundColor = themeColorButton
        newGameButton.backgroundColor = themeColorButton
        countLabel.layer.masksToBounds = true
        countLabel.layer.cornerRadius = 5
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 5
        
    }
    
    private func setColor(for theme: String) {
        switch theme {
        case "Animals":
            themeColorButton = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
        case "Halloween":
            themeColorButton = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case "Sports":
            themeColorButton = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case "Food":
            themeColorButton = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        case "Professions":
            themeColorButton = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case "Faces":
            themeColorButton = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        default:
            themeColorButton = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            themeColorBackground = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
            
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

















//    private var animals: [String] = []
//    private var halloween: [String] = []
//    private var sports: [String] = []
//    private var food: [String] = []
//    private var professions: [String] = []
//    private var faces: [String] = []
//    private func setUpTheme(){
//        animals = ["🐶", "🐵", "🐸", "🐧", "🦊", "🦁"]
//        halloween = ["🎃", "🧞‍♀️", "🧛‍♂️", "🧝‍♀️", "🧜‍♀️", "🧟‍♂️"]
//        sports = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏒"]
//        food = ["🍕", "🍔", "🌮", "🍟", "🍗", "🥩"]
//        professions = ["👩‍🍳", "👮‍♀️", "👩‍🚒", "👨‍🚀", "👨‍🔧", "👨‍⚕️"]
//        faces = ["😙", "😍", "🙃", "😋", "😇", "🤓"]
//    }

//private(set) var flipCount = 0 {
//    didSet {
//        scoreLabel.text = "Flips: \(flipCount)"
//    }
//}

