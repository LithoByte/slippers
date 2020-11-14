//
//  Id.swift
//  LUX
//
//  Created by Elliot Schrock on 12/23/19.
//

import Foundation

public protocol Ided {
    var id: Id<Self> { get }
}

public struct Id<Type>: Codable, Hashable, RawRepresentable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public init(from decoder: Decoder) throws {
        rawValue = try Int(from: decoder)
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

extension Id: ExpressibleByIntegerLiteral {
  public init(integerLiteral: IntegerLiteralType) {
    self.init(rawValue: RawValue(integerLiteral: integerLiteral))
  }
}

@available(iOS 13, *)
extension Id: Identifiable {
    public var id: Int {
        return rawValue
    }
}
