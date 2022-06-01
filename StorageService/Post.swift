//
//  Post.swift
//  Navigation
//
//  Created by Ален Авако on 11.09.2021.
//

import UIKit

public struct NewPost {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    public init(author: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}

public let post1 = NewPost(author: "Natasha Romanoff", description: "with friends", image: "post1", likes: 333, views: 333)
public let post2 = NewPost(author: "Tony Stark", description: "brand new suit", image: "post2", likes: 123, views: 123)
public let post3 = NewPost(author: "Clint Barton", description: "Me)", image: "post3", likes: 234, views: 356)
public let post4 = NewPost(author: "Piter Parker", description: "Venice", image: "post4", likes: 435, views: 464)
    
public var arrayOfPosts = [post1, post2, post3, post4]

