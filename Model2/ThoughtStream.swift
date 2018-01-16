//
//  ThoughtStream.swift
//
//  Created by Rafay on 15/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class ThoughtStream: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let metaName = "metaName"
    static let thoughts = "thoughts"
    static let start = "start"
    static let more = "more"
  }

  // MARK: Properties
  public var metaName: String?
  public var thoughts: [Thoughts]?
  public var start: Int?
  public var more: Bool? = false

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
    metaName <- map[SerializationKeys.metaName]
    thoughts <- map[SerializationKeys.thoughts]
    start <- map[SerializationKeys.start]
    more <- map[SerializationKeys.more]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = metaName { dictionary[SerializationKeys.metaName] = value }
    if let value = thoughts { dictionary[SerializationKeys.thoughts] = value.map { $0.dictionaryRepresentation() } }
    if let value = start { dictionary[SerializationKeys.start] = value }
    dictionary[SerializationKeys.more] = more
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.metaName = aDecoder.decodeObject(forKey: SerializationKeys.metaName) as? String
    self.thoughts = aDecoder.decodeObject(forKey: SerializationKeys.thoughts) as? [Thoughts]
    self.start = aDecoder.decodeObject(forKey: SerializationKeys.start) as? Int
    self.more = aDecoder.decodeBool(forKey: SerializationKeys.more)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(metaName, forKey: SerializationKeys.metaName)
    aCoder.encode(thoughts, forKey: SerializationKeys.thoughts)
    aCoder.encode(start, forKey: SerializationKeys.start)
    aCoder.encode(more, forKey: SerializationKeys.more)
  }

}
