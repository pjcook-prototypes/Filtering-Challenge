//
//  Models.swift
//  Filtering
//
//  Created by PJ on 01/04/2022.
//

import Foundation

public struct Card: Codable {
    public var id: String
    public let cardType: CardType
    public let name: String
    public let filtering: Filtering?    // optional
}

public enum CardType: String, Codable {
    case carousel
    case banner
    case departments
    case recommendations
}

public typealias FilterGroupID = String
public struct Filtering: Codable, Equatable {
    public let groupId: FilterGroupID?
    public let filters: [Filter]
}

public struct Filter: Codable, Equatable {
    public let filter: FilterType
    public let value: String?
    public let range: FilterRange?
}

public struct FilterRange: Codable, Equatable {
    public let min: Double
    public let max: Double
}

public enum FilterType: String, Codable, Equatable {
    case controlGroup
    
    case osVersionEquals
    case osVersionMajorEquals
    case osVersionMinorEquals
    case osVersionGreaterThan
    case osVersionMajorGreaterThan
    case osVersionMinorGreaterThan
    case osVersionLessThan
    case osVersionMajorLessThan
    case osVersionMinorLessThan
    
    case appVersionEquals
    case appVersionMajorEquals
    case appVersionMinorEquals
    case appVersionGreaterThan
    case appVersionMajorGreaterThan
    case appVersionMinorGreaterThan
    case appVersionLessThan
    case appVersionMajorLessThan
    case appVersionMinorLessThan
}

public struct UserDetails {
    public let osVersion: OperatingSystemVersion?
    public let appVersion: OperatingSystemVersion?
}


