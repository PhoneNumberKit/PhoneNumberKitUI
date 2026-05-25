//
//  CountryCodePicker.swift
//  PhoneNumberKitUI
//
//  Extracted from PhoneNumberUtility.swift during the 5.0 reboot.
//  This UI configuration type moved out of the foundation package into PhoneNumberKitUI.
//

#if canImport(UIKit)
/// Configuration for the CountryCodePicker presented from PhoneNumberTextField if `withDefaultPickerUI` is `true`
public enum CountryCodePicker {
    /// Common Country Codes are shown below the Current section in the CountryCodePicker by default
    public static var commonCountryCodes: [String] = []

    /// When the Picker is shown from the textfield it is presented modally
    public static var forceModalPresentation: Bool = false

    /// Set the search bar of the Picker to always visible
    public static var alwaysShowsSearchBar: Bool = false
}
#endif
