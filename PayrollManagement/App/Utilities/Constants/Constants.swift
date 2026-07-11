//
//  Constants.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 11/07/26.
//


import Foundation
import SwiftUI

struct Constants {
    
    // MARK: APP RELATED (MAIN)
    
    /// Apple ID
    static var AppleID = ""
    
    /// App Bundle ID
    static let BUNDLE_ID = ""
    
    /// Team ID
    static var TeamID = ""
    
    /// App Name
    static var appname: String = "Payroll Hub"
    
    /// App Link
    static var applink = "https://apps.apple.com/us/app/id\(AppleID)"
    
    
    //--------------------------------------------------------------------------------------------------------------
    
    /// A boolean constant that indicates whether the current device is an iPad.
    static let is_iPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    /// A boolean constant that indicates whether the current device is an iPhone.
    static let is_iPhone: Bool = UIDevice.current.userInterfaceIdiom == .phone
    
    /// Device width And height
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHight: CGFloat = UIScreen.main.bounds.height
    
    /// A boolean constant that indicates whether the current device is an small iPhone like SE and 8.
    static let smallphone = UIDevice.current.userInterfaceIdiom == .phone && screenHight <= 680
    /// A boolean constant that indicates whether the current device is an small iPhone like 11, 11 pro, 11 pro max etc..,.
    static let largephone = UIDevice.current.userInterfaceIdiom == .phone && screenHight > 680
    
    /// App Version
    static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    /// App Build
    static let appbuild: String = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    
    /// App Version
    static let version = UIDevice.current.systemVersion
    
    /// Device Name
    static let DeviceName = UIDevice.current.name
    
    /// Device Model
    static let DeviceModel = UIDevice.current.model
    
    /// Device country
    static let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String ?? ""
    
    /// Device Language
    static let lang = NSLocale.current.identifier
    static let langCode = Locale.current.languageCode ?? ""
    
    /// Device Type
    static let deviceType = "IOS"
    
    /// Feedback URL
    static let bundleID = Bundle.main.bundleIdentifier
    
}
