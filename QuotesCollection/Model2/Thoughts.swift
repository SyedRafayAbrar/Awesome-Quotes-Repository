//
//  Thoughts.swift
//
//  Created by Rafay on 15/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Thoughts: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let uri = "uri"
    static let quoteFragment = "quoteFragment"
    static let quote = "quote"
    static let naturalId = "naturalId"
    static let thoughtThemes = "thoughtThemes"
    static let visible = "visible"
    static let thoughtAuthor = "thoughtAuthor"
    static let shortUri = "shortUri"
    static let sortField = "sortField"
  }

  // MARK: Properties
  public var uri: String?
  public var quoteFragment: String?
  public var quote: String?
  public var naturalId: String?
  public var thoughtThemes: [ThoughtThem]?
  public var visible: Bool? = false
  public var thoughtAuthor: ThoughtAuth?
  public var shortUri: String?
  public var sortField: Int?

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
    quoteFragment <- map[SerializationKeys.quoteFragment]
    quote <- map[SerializationKeys.quote]
    naturalId <- map[SerializationKeys.naturalId]
    thoughtThemes <- map[SerializationKeys.thoughtThemes]
    visible <- map[SerializationKeys.visible]
    thoughtAuthor <- map[SerializationKeys.thoughtAuthor]
    shortUri <- map[SerializationKeys.shortUri]
    sortField <- map[SerializationKeys.sortField]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = uri { dictionary[SerializationKeys.uri] = value }
    if let value = quoteFragment { dictionary[SerializationKeys.quoteFragment] = value }
    if let value = quote { dictionary[SerializationKeys.quote] = value }
    if let value = naturalId { dictionary[SerializationKeys.naturalId] = value }
    if let value = thoughtThemes { dictionary[SerializationKeys.thoughtThemes] = value.map { $0.dictionaryRepresentation() } }
    dictionary[SerializationKeys.visible] = visible
    if let value = thoughtAuthor { dictionary[SerializationKeys.thoughtAuthor] = value.dictionaryRepresentation() }
    if let value = shortUri { dictionary[SerializationKeys.shortUri] = value }
    if let value = sortField { dictionary[SerializationKeys.sortField] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.uri = aDecoder.decodeObject(forKey: SerializationKeys.uri) as? String
    self.quoteFragment = aDecoder.decodeObject(forKey: SerializationKeys.quoteFragment) as? String
    self.quote = aDecoder.decodeObject(forKey: SerializationKeys.quote) as? String
    self.naturalId = aDecoder.decodeObject(forKey: SerializationKeys.naturalId) as? String
    self.thoughtThemes = aDecoder.decodeObject(forKey: SerializationKeys.thoughtThemes) as? [ThoughtThem]
    self.visible = aDecoder.decodeBool(forKey: SerializationKeys.visible)
    self.thoughtAuthor = aDecoder.decodeObject(forKey: SerializationKeys.thoughtAuthor) as? ThoughtAuth
    self.shortUri = aDecoder.decodeObject(forKey: SerializationKeys.shortUri) as? String
    self.sortField = aDecoder.decodeObject(forKey: SerializationKeys.sortField) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(uri, forKey: SerializationKeys.uri)
    aCoder.encode(quoteFragment, forKey: SerializationKeys.quoteFragment)
    aCoder.encode(quote, forKey: SerializationKeys.quote)
    aCoder.encode(naturalId, forKey: SerializationKeys.naturalId)
    aCoder.encode(thoughtThemes, forKey: SerializationKeys.thoughtThemes)
    aCoder.encode(visible, forKey: SerializationKeys.visible)
    aCoder.encode(thoughtAuthor, forKey: SerializationKeys.thoughtAuthor)
    aCoder.encode(shortUri, forKey: SerializationKeys.shortUri)
    aCoder.encode(sortField, forKey: SerializationKeys.sortField)
  }

}
