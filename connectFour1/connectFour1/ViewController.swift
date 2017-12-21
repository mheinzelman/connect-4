//
//  ViewController.swift
//  connectFour1
//
//  Created by Max Heinzelman on 12/19/17.
//  Copyright © 2017 Max Heinzelman. All rights reserved.
//

import UIKit

struct node{
    var used : Bool
    var nodeBelow : Bool
    var InARow : Int
    var color : Int  //1 for red 2 for yellow
    var edge : Int  //1 for left 2 for right
}

var nodeData : [node] = []

class ViewController: UIViewController {
    
    /*
     this function accepts the button pushed and returns true or false if this button has four in a row
     surrounding it
    */
    func isWinner(_ sender: AnyObject)-> Bool{
        let buttonNumber : Int = sender.tag
        var i : Int = buttonNumber - 7
        var inARow : Int = 0
        var inARowPrev : Int = -1
        
        //check vertical up
        while(6 < buttonNumber && 0 <= i && inARow != inARowPrev && inARow != 3){ //.changed this from 4 to 3
            inARowPrev = inARow
            //if this new button is the same color as the original button, iterate inARow
            if(nodeData[buttonNumber].color == nodeData[i].color){
                inARow = inARow + 1
            }
            i = i - 7
        }
        
        //if there are three in a row or more not including the original node, return true
        if(inARow >= 3){
            return true
        }
            
        else{
            // search vertically down
            i = buttonNumber + 7
            inARowPrev = -1
            while(buttonNumber < 35 && i < 42 && inARow != inARowPrev && inARow != 3){//.changed this from 4 to 3
                inARowPrev = inARow
                if(nodeData[buttonNumber].color == nodeData[i].color){
                    inARow = inARow + 1
                }
                i = i + 7
            }
        }
        
        //if there are three in a row or more not including the original node, return true
        if(inARow >= 3){
            return true
        }
        
        else{
            //search horizontally to the right
            inARow = 0
            inARowPrev = -1
            i = buttonNumber + 1
            
            while(i < 42 && nodeData[i].edge != 1 && inARow != 3 && inARowPrev != inARow){
                inARowPrev = inARow
                
                //check to see if this node is the same color as the original
                if(nodeData[buttonNumber].color == nodeData[i].color){
                    inARow = inARow + 1
                }
                i = i + 1
            }
            
            
            //if there are three in a row or more not including the original node, return true
            if(inARow >= 3){
                return true
            }
            else{
                // search horizontally to the left
                inARowPrev = -1
                i = buttonNumber - 1
                
                while(i > 0 && nodeData[i].edge != 2 && inARow != 3 && inARowPrev != inARow){
                    inARowPrev = inARow
                    
                    //check to see if this node is the same color as the original
                    if(nodeData[buttonNumber].color == nodeData[i].color){
                        inARow = inARow + 1
                    }
                    i = i - 1
                }
            }
        }
        
        //if there are three in a row or more not including the original node, return true
        if(inARow >= 3){
            return true
        }
            
        else{
            //search diagonally up to the right
            inARow = 0
            inARowPrev = -1
            i = buttonNumber - 6
            
            while(i > 0 && nodeData[i].edge != 1 && inARowPrev != inARow){
                inARowPrev = inARow
                
                //check to see if this node is the same color as the original
                if(nodeData[buttonNumber].color == nodeData[i].color){
                    inARow = inARow + 1
                }
                i = i - 6
            }
            //if there are three in a row or more not including the original node, return true
            if(inARow >= 3){
                return true
            }
            
            else{
                //search diagonally down to the left
                inARowPrev = -1
                i = buttonNumber + 6
                
                while(i < 42 && nodeData[i].edge != 2 && inARowPrev != inARow){
                    inARowPrev = inARow
                    
                    //check to see if this node is the same color as the original
                    if(nodeData[buttonNumber].color == nodeData[i].color){
                        inARow = inARow + 1
                    }
                    i = i + 6
                }
            }
        }
        
        //if there are three in a row or more not including the original node, return true
        if(inARow >= 3){
            return true
        }
        
        else{
            //search diagonally up to the left
            inARow = 0
            inARowPrev = -1
            i = buttonNumber - 8
            
            while(i > 0 && nodeData[i].edge != 2 && inARowPrev != inARow){
                inARowPrev = inARow
                
                //check to see if this node is the same color as the original
                if(nodeData[buttonNumber].color == nodeData[i].color){
                    inARow = inARow + 1
                }
                i = i - 8
            }
            //if there are three in a row or more not including the original node, return true
            if(inARow >= 3){
                return true
            }
            
            else{
                //search diagonally down to the right
                inARowPrev = -1
                i = buttonNumber + 8
                
                while(i < 42 && nodeData[i].edge != 1 && inARowPrev != inARow){
                    inARowPrev = inARow
                    
                    //check to see if this node is the same color as the original
                    if(nodeData[buttonNumber].color == nodeData[i].color){
                        inARow = inARow + 1
                    }
                    i = i + 8
                }
            }
        }
        
        //if there are three in a row or more not including the original node, return true
        if(inARow >= 3){
            return true
        }
        //return false if it makes it through all these cases without four in a row
        return false
    }
    
    
    /*
        this function sets up an array that contains the information about each slot in the
        connect four board like whether it is an edge or if it is the bottom
    */
    func setArray(){
        //reserves enough space in the array for all of the holes
        nodeData.reserveCapacity(42)
        
        var iterator : Int = 0
        
        //creates 42 nodes to represent each hole in the board and intitializes them
        while(iterator < 42){
            nodeData.append(node.init(used: false, nodeBelow: false, InARow: 0, color: 0, edge : 0))
            // if the node is any of the bottom row holes, nodeBelow is set to true so that a coin can be added there
            if(34 < iterator && iterator < 42){
              nodeData[iterator].nodeBelow = true
            }
            
            //determines if this node will be a left edge on the playing board
            if(iterator == 0 || iterator == 7 || iterator == 14 || iterator == 21 || iterator == 28 || iterator == 35){
                nodeData[iterator].edge = 1
            }
            
            //determines if this node will be a right edge on the playing board
            if(iterator == 6 || iterator == 13 || iterator == 20 || iterator == 27 || iterator == 34 || iterator == 41){
                nodeData[iterator].edge = 2
            }
            
            iterator = iterator + 1
        }
    }
    
    /*
        this function is called when a
    */
    var playerTurn: Int = 1
    @IBAction func Position(_ sender: AnyObject) {
        if(nodeData[sender.tag].used == false && nodeData[sender.tag].nodeBelow == true){
            if(playerTurn == 1){
                //set the button to be a yellow coin
                sender.setImage(UIImage(named: "Yellow1.png"), for: UIControlState())
                
                nodeData[sender.tag].used = true //set it as a used space
                nodeData[sender.tag].color = 2 // set it as a yellow coin
                // allow coins to be added on top of this one
                if(!(0 <= sender.tag && sender.tag < 7)){
                    nodeData[sender.tag - 7].nodeBelow = true
                }
                
                playerTurn = 2 // update player turn
            }
            else if(playerTurn == 2){
                //set button to be a red coin
                sender.setImage(UIImage(named: "Red.png"), for: UIControlState())
                
                nodeData[sender.tag].used = true//set it as a used space
                nodeData[sender.tag].color = 1 // set it as a red coin
                // allow coins to be added on top of this one
                if(!(0 <= sender.tag && sender.tag < 7)){
                    nodeData[sender.tag - 7].nodeBelow = true
                }
                
                playerTurn = 1// update player turn
            }
            
            if(isWinner(sender) == true){
                print("Winner!!")           //change this to go to a new screen and restart the game
            }
        }
        
    }
    
    @IBAction func ResetButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the array with the information about the board
        setArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

