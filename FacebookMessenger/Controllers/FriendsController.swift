//
//  ViewController.swift
//  FacebookMessenger
//
//  Created by Lucas Nascimento on 27/02/2018.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit
import CoreData

class FriendsController: UICollectionViewController {
    
    private let cellId = "cellId"
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        
        if let message = messages?[indexPath.item] {
            cell.message = message
        }
        
        return cell
    }
    
    
}

extension FriendsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

extension FriendsController {
    
    func setupData() {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuckprofile"
        
        let message =  NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = mark
        message.date = Date() as NSDate
        message.text = "Hello, my name is Mark. Nice to meet you..."
        
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        messageSteve.friend = steve
        messageSteve.date = Date() as NSDate
        messageSteve.text = "Hello I'm Steve"
        
        do {
            try(context.save())
        } catch let err {
            print(err)
        }
        
        messages = [message, messageSteve]
        //loadData()
        
    }
    
    func loadData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            
            do {
                try(context.execute(fetchRequest))
                print(context)
                
            } catch let err {
                print(err)
            }
            
        }
    }
}






