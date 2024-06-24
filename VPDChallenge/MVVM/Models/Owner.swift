//
//  Owner.swift
//  VPDChallenge
//
//  Created by Masud Onikeku on 21/06/2024.
//

import Foundation

public class Owner : NSObject, NSCoding, Codable {
    
    public var login: String
    public var id: Int
    public var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatar = "avatar_url"
    }
    
    enum Key:String {
        
        case login = "login"
        case id = "id"
        case avatar = "avatar"
    }
    
    public init(login: String, id: Int, avatar: String) {
        self.login = login
        self.id = id
        self.avatar = avatar
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(login, forKey: Key.login.rawValue)
        coder.encode(id, forKey: Key.id.rawValue)
        coder.encode(avatar, forKey: Key.avatar.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mLogin = coder.decodeObject(forKey: Key.login.rawValue) as! String
        let mId = coder.decodeInt64(forKey: Key.id.rawValue)
        let mAvatar = coder.decodeObject(forKey: Key.avatar.rawValue) as! String
        
        self.init(login: mLogin, id: Int(mId), avatar: mAvatar)
    }
    
}

public class APIRepos : NSObject, NSCoding {

    public let repos: [APIRepo]
    
    public init(repos: [APIRepo]) {
        self.repos = repos
    }
    
    enum Key:String {
        case repos = "repos"
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(repos, forKey: Key.repos.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mLogin = coder.decodeObject(forKey: Key.repos.rawValue) as! [APIRepo]
        self.init(repos: mLogin)
    }
    
}

public class APIRepo : NSObject, NSCoding, Codable {

    public let id: Int
    public let name: String
    public let descriptions: String?
    public let url: String
    public let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case descriptions
        case url
        case owner
    }
    
    public init(id: Int, name: String, description: String?, url: String, owner: Owner) {
        self.id = id
        self.name = name
        self.descriptions = description
        self.url = url
        self.owner = owner
    }
    
    enum Key:String {
        
        case name = "name"
        case id = "id"
        case description = "description"
        case url = "url"
        case owner = "owner"
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: Key.name.rawValue)
        coder.encode(id, forKey: Key.id.rawValue)
        coder.encode(descriptions, forKey: Key.description.rawValue)
        coder.encode(url, forKey: Key.url.rawValue)
        coder.encode(owner, forKey: Key.owner.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mName = coder.decodeObject(forKey: Key.name.rawValue) as! String
        let mId = coder.decodeInt64(forKey: Key.id.rawValue)
        let mDescription = coder.decodeObject(forKey: Key.description.rawValue) as! String?
        let mUrl = coder.decodeObject(forKey: Key.url.rawValue) as! String
        let mOwner = coder.decodeObject(forKey: Key.owner.rawValue) as! Owner
        
        self.init(id: Int(mId), name: mName, description: mDescription, url: mUrl, owner: mOwner)
    }
    
    
}

struct APIResult : Codable {
    
    public let total_count: Int
    public let incomplete_results: Bool
    public let items: [APIRepo]
    
    enum CodingKeys: String, CodingKey {
        case total_count
        case incomplete_results
        case items
        
    }
    
}
