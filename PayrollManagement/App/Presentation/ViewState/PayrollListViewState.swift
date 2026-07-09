//
//  PayrollListViewState.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//


import Foundation

enum PayrollListViewState {
    case loading
    case empty
    case loaded
    case error(String)
}