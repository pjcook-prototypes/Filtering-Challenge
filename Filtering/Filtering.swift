//
//  Filtering.swift
//  Filtering
//
//  Created by PJ on 01/04/2022.
//

import Foundation

public func filterLayoutResponse(callerDetails: UserDetails, cards: [Card]) -> [Card] {
    // Valid cards to return
    var filteredCards: [Card] = []
    // Used to hold groupIDs where there are no valid matching filtered cards
    var invalidGroupIDs = Set<FilterGroupID>()
    // Used to hold the valid filtered cards
    var resolvedFilteredCards: [FilterGroupID: Card] = [:]
    
    for i in (0..<cards.count) {
        let card = cards[i]
        
        // If no filters just save and continue
        guard let filters = card.filtering else {
            filteredCards.append(card)
            continue
        }
        
        // If no groupID then validate, save if valid and continue
        guard let groupID = filters.groupId else {
            if card.validate(filter: filters, with: callerDetails) {
                filteredCards.append(card)
            }
            continue
        }
        
        // Check if groupID already validated with no results
        guard !invalidGroupIDs.contains(groupID) else { continue }
        
        // Check if groupID already validated with result
        if let resolvedCard = resolvedFilteredCards[groupID] {
            if resolvedCard.id == card.id {
                filteredCards.append(card)
            }
            continue
        }
        
        // Filter group cards for first match
        let validFilteredCards = cards[(i..<cards.count)].filter { $0.filtering?.groupId == groupID && $0.validate(filter: $0.filtering!, with: callerDetails) }
        var filteredCard = validFilteredCards.first
        if validFilteredCards.count > 1 {
            filteredCard = validFilteredCards.first { $0.filtering!.filters.first?.filter != .controlGroup } ?? filteredCard
        }
        
        // Save filtered card
        if let filteredCard = filteredCard {
            resolvedFilteredCards[groupID] = filteredCard
            if filteredCard.id == card.id {
                filteredCards.append(card)
            }
        } else {
            invalidGroupIDs.insert(groupID)
        }
    }
    
    return filteredCards
}

