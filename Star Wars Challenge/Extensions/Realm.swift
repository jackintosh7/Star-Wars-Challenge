//
//  RealmSwift.swift
//   Challenge
//
//  Created by Jack Higgins on 1/27/21.
//

import RealmSwift

extension Realm {
   func write(_ block: (Realm) throws -> ()) throws {
      try self.write {
         try block(self)
      }
   }
}
