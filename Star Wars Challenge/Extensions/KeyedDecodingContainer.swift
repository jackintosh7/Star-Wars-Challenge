//
//  KeyedDecodingContainer.swift
//   Challenge
//
//  Created by Jack Higgins on 1/27/21.
//

extension KeyedDecodingContainer {

   func decode<Type>(
      type: Type.Type = Type.self,
      _ key: Key
   ) throws -> Type where Type: Decodable {
      try decode(type, forKey: key)
   }

   func decodeIfPresent<Type>(
      type: Type.Type = Type.self,
      _ key: Key
   ) throws -> Type? where Type: Decodable {
      try decodeIfPresent(type, forKey: key)
   }
}
