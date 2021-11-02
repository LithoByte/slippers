//
//  StringId.swift
//  Slippers
//
//  Created by Calvin Collins on 11/2/21.
//

import Foundation

//
//  Id.swift
//  LUX
//
//  Created by Elliot Schrock on 12/23/19.
//

import Foundation

public struct StringId<Type>: Codable, Hashable, RawRepresentable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(from decoder: Decoder) throws {
        rawValue = try String(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }
}

extension StringId: CustomPlaygroundDisplayConvertible {
  public var playgroundDescription: Any {
    return self.rawValue
  }
}

extension StringId: Comparable {
    public static func < (lhs: StringId<Type>, rhs: StringId<Type>) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension StringId: Equatable {}

extension StringId: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

@available(iOS 13, *)
extension StringId: Identifiable {
    public var id: String {
        return rawValue
    }
}

