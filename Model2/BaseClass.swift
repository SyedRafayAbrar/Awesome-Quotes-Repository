//
//  BaseClass.swift
//
//  Created by Rafay on 15/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class BaseClass: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let thoughtStream = "thoughtStream"
  }

  // MARK: Properties
  public var thoughtStream: ThoughtStream?

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
    thoughtStream <- map[SerializationKeys.thoughtStream]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = thoughtStream { dictionary[SerializationKeys.thoughtStream] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.thoughtStream = aDecoder.decodeObject(forKey: SerializationKeys.thoughtStream) as? ThoughtStream
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(thoughtStream, forKey: SerializationKeys.thoughtStream)
  }

}
