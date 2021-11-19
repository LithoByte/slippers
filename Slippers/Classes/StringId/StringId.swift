//
//  Id.swift
//  LUX
//
//  Created by Elliot Schrock on 12/23/19.
//

import Foundation

public struct Id<Type>: Codable, Hashable, RawRepresentable {
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

extension Id: CustomPlaygroundDisplayConvertible {
  public var playgroundDescription: Any {
    return self.rawValue
  }
}

extension Id: Comparable {
    public static func < (lhs: Id<Type>, rhs: Id<Type>) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Id: Equatable {}

extension Id: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

@available(iOS 13, *)
extension Id: Identifiable {
    public var id: String {
        return rawValue
    }
}
