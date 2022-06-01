//
//  CoreDataService.swift
//  Navigation
//
//  Created by Ален Авако on 31.05.2022.
//

import Foundation
import StorageService
import UIKit
import CoreData

final class CoreDataService {
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "FavoritePosts", withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let storeName = "FavoritePosts.sqlite"
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        return persistentStoreCoordinator
    }()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    func addFavoritePost(post: NewPost) {
        let fetchRequest = FavoritePosts.fetchRequest()
        do {
            let posts = try managedObjectContext.fetch(fetchRequest)
            if let newFavoritePost = NSEntityDescription.insertNewObject(forEntityName: "FavoritePosts", into: managedObjectContext) as? FavoritePosts {
                newFavoritePost.author = post.author
                newFavoritePost.descriptions = post.description
                newFavoritePost.image = post.image
                newFavoritePost.likes = Int32(post.likes)
                newFavoritePost.views = Int32(post.views)
                
                try managedObjectContext.save()
            }
        } catch let error as NSError {
            print("Favorite post not added to database: %@", error)
        }
    }
    
    func removeFavoritePost(post: NewPost) {
        let fetchRequest = FavoritePosts.fetchRequest()
        do {
            let posts = try managedObjectContext.fetch(fetchRequest)
            if let indexPost = posts.firstIndex(where: { $0.author == post.author }) {
                managedObjectContext.delete(posts[indexPost])
                try managedObjectContext.save()
            }
        } catch let error as NSError {
            print("Favorite post not added to database: %@", error)
        }
    }
    
    func removeAll() {
        let fetchRequest = FavoritePosts.fetchRequest()
        do {
            let posts = try managedObjectContext.fetch(fetchRequest)
            for post in posts {
                managedObjectContext.delete(post)
            }
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Favorite post not added to database: %@", error)
        }
    }
    
    func getFavoritePosts() -> [NewPost] {
        var favoritePosts = [NewPost]()
        let fetchRequest = FavoritePosts.fetchRequest()
        
        do {
            let posts = try managedObjectContext.fetch(fetchRequest)
            
            for post in posts {
                let author = post.author ?? ""
                let description = post.descriptions ?? ""
                let image = post.image ?? ""
                let likes = post.likes
                let views = post.views
                
                let post = NewPost(author: author , description: description, image: image, likes: Int(likes), views: Int(views))
                favoritePosts.append(post)
            }
            
        } catch let error as NSError {
            print("Database operation failed: %@", error)
        }
        return favoritePosts
    }
}
