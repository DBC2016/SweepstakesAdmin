//
//  ViewController.swift
//  BEForClass
//
//  Created by Thomas Crawford on 5/15/16.
//  Copyright © 2016 VizNetwork. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var backendless = Backendless.sharedInstance()
    var sweepstakesArray = [Sweepstakes]()
    
    
    
    @IBOutlet weak private var contestantTableView :UITableView!

    
    
    //MARK: - Winner Methods
    
    
    
    @IBAction private func winnerButtonPressed(button: UIBarButtonItem){
        let sweepstakesCount = UInt32(sweepstakesArray.count)
        let random = Int(arc4random_uniform(sweepstakesCount))
        let winningEntry = sweepstakesArray[random]
        winningEntry.winner = true
        saveNewEntry(winningEntry)
        
        let indexPath = NSIndexPath(forRow: random, inSection: 0)
        contestantTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        contestantTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        
        
    }
    

    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sweepstakesArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let newEntry = sweepstakesArray[indexPath.row]
        cell.textLabel!.text = newEntry.firstName + " " + newEntry.lastName
        cell.detailTextLabel!.text = "\(newEntry.phoneNumber)"
        
        return cell
        
    }

    
    //MARK: - Data Methods
    
    private func saveNewEntry(newEntry: Sweepstakes){
        let dataStore = backendless.data.of(Sweepstakes.ofClass())
        dataStore.save(newEntry, response: { (result) in print("To Do Saved")
            
        }) { (fault) in
            print("Server Reported Error:\(fault)")
            
        }
    }
    
    
    

    
    //MARK: - Temp Add Records & Fetch

    
    
    @IBAction private func fetchEntry(button: UIBarButtonItem){
        let whereClause = "firstName = \(false)"
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        
        var error: Fault?
        let bc = backendless.data.of(Sweepstakes.ofClass()).find(dataQuery, fault:  &error)
        if error == nil {
            sweepstakesArray = bc.getCurrentPage() as! [Sweepstakes]
            
        } else {
            print("Server Error \(error)")
            sweepstakesArray = [Sweepstakes]()
        }
        contestantTableView.reloadData()
        print("Got \(sweepstakesArray.count)")
    }
    



    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

