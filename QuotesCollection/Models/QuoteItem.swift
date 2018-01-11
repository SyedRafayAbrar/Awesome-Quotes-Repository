//
//  QuoteItem.swift
//
//  Created by Umer on 28/12/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper


public final class QuoteItem: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let thought = "thought"
  }

  // MARK: Properties
  public var thought: Thought?

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
    thought <- map[SerializationKeys.thought]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = thought { dictionary[SerializationKeys.thought] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.thought = aDecoder.decodeObject(forKey: SerializationKeys.thought) as? Thought
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(thought, forKey: SerializationKeys.thought)
  }

}
