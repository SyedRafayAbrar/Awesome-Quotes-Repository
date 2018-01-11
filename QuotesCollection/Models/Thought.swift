//
//  Thought.swift
//
//  Created by Umer on 28/12/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Thought: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let articleUrl = "articleUrl"
    static let source = "source"
    static let uri = "uri"
    static let quoteFragment = "quoteFragment"
    static let socialImage = "socialImage"
    static let quote = "quote"
    static let naturalId = "naturalId"
    static let thoughtThemes = "thoughtThemes"
    static let thoughtAuthor = "thoughtAuthor"
    static let visible = "visible"
    static let sortField = "sortField"
    static let notes = "notes"
  }

  // MARK: Properties
  public var articleUrl: String?
  public var source: String?
  public var uri: String?
  public var quoteFragment: String?
  public var socialImage: String?
  public var quote: String?
  public var naturalId: String?
  public var thoughtThemes: [ThoughtThemes]?
  public var thoughtAuthor: ThoughtAuthor?
  public var visible: Bool? = false
  public var sortField: Int?
  public var notes: String?

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
    articleUrl <- map[SerializationKeys.articleUrl]
    source <- map[SerializationKeys.source]
    uri <- map[SerializationKeys.uri]
    quoteFragment <- map[SerializationKeys.quoteFragment]
    socialImage <- map[SerializationKeys.socialImage]
    quote <- map[SerializationKeys.quote]
    naturalId <- map[SerializationKeys.naturalId]
    thoughtThemes <- map[SerializationKeys.thoughtThemes]
    thoughtAuthor <- map[SerializationKeys.thoughtAuthor]
    visible <- map[SerializationKeys.visible]
    sortField <- map[SerializationKeys.sortField]
    notes <- map[SerializationKeys.notes]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = articleUrl { dictionary[SerializationKeys.articleUrl] = value }
    if let value = source { dictionary[SerializationKeys.source] = value }
    if let value = uri { dictionary[SerializationKeys.uri] = value }
    if let value = quoteFragment { dictionary[SerializationKeys.quoteFragment] = value }
    if let value = socialImage { dictionary[SerializationKeys.socialImage] = value }
    if let value = quote { dictionary[SerializationKeys.quote] = value }
    if let value = naturalId { dictionary[SerializationKeys.naturalId] = value }
    if let value = thoughtThemes { dictionary[SerializationKeys.thoughtThemes] = value.map { $0.dictionaryRepresentation() } }
    if let value = thoughtAuthor { dictionary[SerializationKeys.thoughtAuthor] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.visible] = visible
    if let value = sortField { dictionary[SerializationKeys.sortField] = value }
    if let value = notes { dictionary[SerializationKeys.notes] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.articleUrl = aDecoder.decodeObject(forKey: SerializationKeys.articleUrl) as? String
    self.source = aDecoder.decodeObject(forKey: SerializationKeys.source) as? String
    self.uri = aDecoder.decodeObject(forKey: SerializationKeys.uri) as? String
    self.quoteFragment = aDecoder.decodeObject(forKey: SerializationKeys.quoteFragment) as? String
    self.socialImage = aDecoder.decodeObject(forKey: SerializationKeys.socialImage) as? String
    self.quote = aDecoder.decodeObject(forKey: SerializationKeys.quote) as? String
    self.naturalId = aDecoder.decodeObject(forKey: SerializationKeys.naturalId) as? String
    self.thoughtThemes = aDecoder.decodeObject(forKey: SerializationKeys.thoughtThemes) as? [ThoughtThemes]
    self.thoughtAuthor = aDecoder.decodeObject(forKey: SerializationKeys.thoughtAuthor) as? ThoughtAuthor
    self.visible = aDecoder.decodeBool(forKey: SerializationKeys.visible)
    self.sortField = aDecoder.decodeObject(forKey: SerializationKeys.sortField) as? Int
    self.notes = aDecoder.decodeObject(forKey: SerializationKeys.notes) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(articleUrl, forKey: SerializationKeys.articleUrl)
    aCoder.encode(source, forKey: SerializationKeys.source)
    aCoder.encode(uri, forKey: SerializationKeys.uri)
    aCoder.encode(quoteFragment, forKey: SerializationKeys.quoteFragment)
    aCoder.encode(socialImage, forKey: SerializationKeys.socialImage)
    aCoder.encode(quote, forKey: SerializationKeys.quote)
    aCoder.encode(naturalId, forKey: SerializationKeys.naturalId)
    aCoder.encode(thoughtThemes, forKey: SerializationKeys.thoughtThemes)
    aCoder.encode(thoughtAuthor, forKey: SerializationKeys.thoughtAuthor)
    aCoder.encode(visible, forKey: SerializationKeys.visible)
    aCoder.encode(sortField, forKey: SerializationKeys.sortField)
    aCoder.encode(notes, forKey: SerializationKeys.notes)
  }

}
