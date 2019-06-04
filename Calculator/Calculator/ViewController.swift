//
//  ViewController.swift
//  Calculator
//
//  Created by Billy Rebecchi on 04/06/2019.
//  Copyright © 2019 Billy Rebecchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let buttonLabels = ["1", "2", "3", "+", "4", "5", "6", "-", "7", "8", "9", "*", "C", "0", "=", "/"]
    
    @IBOutlet weak var calculatorOutput: UILabel!
    @IBOutlet weak var buttonCollection: UICollectionView!
    
    var outputText: String = "0"
    
    var firstNum: Int = 0
    var userSum: String?
    
    // Keep track of whether we have received an answer
    var answer: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the method to update the calculator screen
        updateCalculatorScreen()
        
        // Set this class as the delegate for the collection view
        buttonCollection.delegate = self
        buttonCollection.dataSource = self
        
    }
    
    // Function to update the screen
    private func updateCalculatorScreen() {
        
        // Set the label text
        calculatorOutput.text = outputText
        
    }
    
    // Function to handle a button press
    public func buttonPressed(btn: Int) {
        
        // Check whether we currently have an answer
        if answer {
            
            // Clear the toggle
            answer = false
            
            // Clear variables
            outputText = "0"
            firstNum = 0
            userSum = nil
        }
        
        // Check whether we are able to cast the button pressed to a number (if not, it must be a sum)
        if let number = Int(buttonLabels[btn]) {
            
            // Check for empty output text
            if outputText == "0" {
                outputText = ""
            }
            
            // Append the number to the output
            outputText += buttonLabels[btn]
            
        }
        else {
            
            // Get the value of the sum
            let sum = buttonLabels[btn]
            
            // Check the value of the sum
            if sum == "C" {
                
                // Clear the output text
                outputText = "0"
                
                // Clear variables
                userSum = nil
                firstNum = 0
                
            }
            else if sum == "=" {
                
                // Set answer to true
                answer = true
                
                // Check the value of user sum
                if userSum == "+" {
                    
                    // Set the output
                    outputText = String(firstNum + Int(outputText)!)
                    
                }
                else if userSum == "-" {
                    
                    // Set the output
                    outputText = String(firstNum - Int(outputText)!)
                    
                }
                else if userSum == "*" {
                    
                    // Set the output
                    outputText = String(firstNum * Int(outputText)!)
                    
                }
                else if userSum == "/" {
                    
                    // Set the output
                    outputText = String(firstNum / Int(outputText)!)
                    
                }
                
                // Reset the user sum
                userSum = nil
                
            }
            else {
                
                // Get the first number
                firstNum = Int(outputText)!
                
                // Set the value to the users sum
                userSum = sum
                
                // Reset the output text
                outputText = "0"
                
            }
            
        }
        
        // Update the screen
        updateCalculatorScreen()
        
    }
}

// Override the UI COllection View delegate and data source
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    // Override the number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonLabels.count
    }
    
    // Override the creation of the cell at each location
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Create the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CustomCollectionViewCell
        cell.cellLabel.text = buttonLabels[indexPath.row]
        
        return cell
    }
    
    // Override the size of each individual item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Get the width of the collection view and divide by 4
        let size = collectionView.bounds.size.width*0.22
        
        return CGSize(width: size, height: size)
    }
    
    // Function to set the click for each item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        buttonPressed(btn: indexPath.row)
        
    }
    
}

// Define a custom view cell
class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    
}
