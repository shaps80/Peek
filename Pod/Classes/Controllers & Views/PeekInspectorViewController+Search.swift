//
//  PeekInspectorViewController+Search.swift
//  Peek
//
//  Created by Shaps Benkau on 20/03/2018.
//

import UIKit

extension PeekInspectorViewController {
    
    private var isSearching: Bool {
        return searchController.isActive
            && searchController.searchBar.text?.isEmpty == false
    }
    
//    private func numberOfCategories() -> Int {
//        return isSearching
//            ? filteredCategories.count
//            : categories.count
//    }
//
//    private func numberOfSites(for categoryIndex: Int) -> Int {
//        return isSearching
//            ? filteredCategories[categoryIndex].sites.count
//            : categories[categoryIndex].sites.count
//    }
//
//    private func category(for index: Int) -> Category {
//        return isSearching
//            ? filteredCategories[index]
//            : categories[index]
//    }
//
//    private func site(for indexPath: IndexPath) -> Site {
//        return isSearching
//            ? filteredCategories[indexPath.section].sites[indexPath.item]
//            : categories[indexPath.section].sites[indexPath.item]
//    }
//
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchText = (searchController.searchBar.text ?? "").trimmingCharacters(in: .whitespaces)
//        filteredCategories = categories.flatMap {
//            let sites = $0.sites.filter {
//                $0.title.localizedCaseInsensitiveContains(searchText)
//                    || $0.author.localizedCaseInsensitiveContains(searchText)
//            }
//
//            guard !sites.isEmpty else { return nil }
//            return Category(title: $0.title, slug: $0.slug, summary: $0.summary, sites: sites)
//        }
//    }
    
}

extension PeekInspectorViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
