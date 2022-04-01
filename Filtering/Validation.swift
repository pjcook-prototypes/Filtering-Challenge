//
//  Validation.swift
//  Filtering
//
//  Created by PJ on 01/04/2022.
//

import Foundation

public extension Card {
    func validate(filter: Filtering, with callerDetails: UserDetails) -> Bool {
        filter.filters.reduce(true, { $0 && validate(filter: $1, with: callerDetails) })
    }
    
    func validate(filter: Filter, with callerDetails: UserDetails) -> Bool {
        switch filter.filter {
        
        case .controlGroup:
            return true
            
        // OS Version
        case .osVersionEquals:
            return callerDetails.osVersion != nil && OperatingSystemVersion(value: filter.value) == callerDetails.osVersion
        case .osVersionMajorEquals:
            return OperatingSystemVersion(value: filter.value)?.validateMajor(value: callerDetails.osVersion, type: .equals) ?? false
        case .osVersionMinorEquals:
            return OperatingSystemVersion(value: filter.value)?.validateMinor(value: callerDetails.osVersion, type: .equals) ?? false
        case .osVersionGreaterThan:
            return callerDetails.osVersion != nil && callerDetails.osVersion! > OperatingSystemVersion(value: filter.value)
        case .osVersionMajorGreaterThan:
            return OperatingSystemVersion(value: filter.value)?.validateMajor(value: callerDetails.osVersion, type: .greater) ?? false
        case .osVersionMinorGreaterThan:
            return OperatingSystemVersion(value: filter.value)?.validateMinor(value: callerDetails.osVersion, type: .greater) ?? false
        case .osVersionLessThan:
            return callerDetails.osVersion != nil && callerDetails.osVersion! < OperatingSystemVersion(value: filter.value)
        case .osVersionMajorLessThan:
            return OperatingSystemVersion(value: filter.value)?.validateMajor(value: callerDetails.osVersion, type: .lessThan) ?? false
        case .osVersionMinorLessThan:
            return OperatingSystemVersion(value: filter.value)?.validateMinor(value: callerDetails.osVersion, type: .lessThan) ?? false
            
        // App Version
        case .appVersionEquals:
            return callerDetails.appVersion != nil && OperatingSystemVersion(value: filter.value) == callerDetails.appVersion
        case .appVersionMajorEquals:
            return OperatingSystemVersion(value: filter.value)?.validateMajor(value: callerDetails.appVersion, type: .equals) ?? false
        case .appVersionMinorEquals:
            return OperatingSystemVersion(value: filter.value)?.validateMinor(value: callerDetails.appVersion, type: .equals) ?? false
        case .appVersionGreaterThan:
            return callerDetails.appVersion != nil && callerDetails.appVersion! > OperatingSystemVersion(value: filter.value)
        case .appVersionMajorGreaterThan:
            return OperatingSystemVersion(value: filter.value)?.validateMajor(value: callerDetails.appVersion, type: .greater) ?? false
        case .appVersionMinorGreaterThan:
            return OperatingSystemVersion(value: filter.value)?.validateMinor(value: callerDetails.appVersion, type: .greater) ?? false
        case .appVersionLessThan:
            return callerDetails.appVersion != nil && callerDetails.appVersion! < OperatingSystemVersion(value: filter.value)
        case .appVersionMajorLessThan:
            return OperatingSystemVersion(value: filter.value)?.validateMajor(value: callerDetails.appVersion, type: .lessThan) ?? false
        case .appVersionMinorLessThan:
            return OperatingSystemVersion(value: filter.value)?.validateMinor(value: callerDetails.appVersion, type: .lessThan) ?? false
        }
    }
}


