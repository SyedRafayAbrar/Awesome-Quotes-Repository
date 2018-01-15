//
//  ThoughtAuthor.swift
//
//  Created by Rafay on 15/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class ThoughtAuth: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let uri = "uri"
    static let name = "name"
  }

  // MARK: Properties
  public var uri: String?
  public var name: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    uri <- map[SerializationKeys.uri]
    name <- map[SerializationKeys.name]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = uri { dictionary[SerializationKeys.uri] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.uri = aDecoder.decodeObject(forKey: SerializationKeys.uri) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(uri, forKey: SerializationKeys.uri)
    aCoder.encode(name, forKey: SerializationKeys.name)
  }

}
