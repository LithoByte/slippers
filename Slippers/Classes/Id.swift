//
//  Id.swift
//  LUX
//
//  Created by Elliot Schrock on 12/23/19.
//

import Foundation

public typealias Idable = Codable & Comparable & Hashable

public protocol Ided {
    associatedtype IdType: Idable
    var id: Id<Self, IdType> { get }
}

public struct Id<Type, IdType: Idable>: Codable, Hashable, RawRepresentable {
    public let rawValue: IdType
    
    public init(rawValue: IdType) {
        self.rawValue = rawValue
    }

    public init(from decoder: Decoder) throws {
        rawValue = try IdType(from: decoder)
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
    public static func < (lhs: Id<Type, IdType>, rhs: Id<Type, IdType>) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Id: Equatable {}

extension Id: ExpressibleByIntegerLiteral where IdType == Int {
  public init(integerLiteral: IntegerLiteralType) {
    self.init(rawValue: RawValue(integerLiteral: integerLiteral))
  }
}

extension Id: ExpressibleByStringLiteral, ExpressibleByUnicodeScalarLiteral, ExpressibleByExtendedGraphemeClusterLiteral where IdType == String {
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias UnicodeScalarLiteralType = String
    
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: String(stringLiteral: value))
    }
}

@available(iOS 13, *)
extension Id: Identifiable {
    public var id: IdType {
        return rawValue
    }
}
