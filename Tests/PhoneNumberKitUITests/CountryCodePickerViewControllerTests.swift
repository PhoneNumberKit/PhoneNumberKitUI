#if os(iOS)

@testable import PhoneNumberKitUI
import PhoneNumberKit
import XCTest

@MainActor
final class CountryCodePickerViewControllerTests: XCTestCase {
    private var controller: CountryCodePickerViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()

        let utility = PhoneNumberUtility()
        controller = CountryCodePickerViewController(
            utility: utility,
            options: nil
        )

        var unitedStates = try XCTUnwrap(
            CountryCodePickerViewController.Country(for: "US", with: utility)
        )
        unitedStates.name = "United States"

        var france = try XCTUnwrap(
            CountryCodePickerViewController.Country(for: "FR", with: utility)
        )
        france.name = "France"

        var unitedKingdom = try XCTUnwrap(
            CountryCodePickerViewController.Country(for: "GB", with: utility)
        )
        unitedKingdom.name = "United Kingdom"

        controller.allCountries = [unitedStates, france, unitedKingdom]
    }

    override func tearDown() {
        controller = nil
        super.tearDown()
    }

    func testSearchMatchesCountryNameCodeAndPrefixCaseInsensitively() {
        XCTAssertEqual(controller.countries(matching: "fr").map(\.code), ["FR"])
        XCTAssertEqual(controller.countries(matching: "UNITED").map(\.code), ["US", "GB"])
        XCTAssertEqual(controller.countries(matching: "+44").map(\.code), ["GB"])
    }

    func testSearchReturnsNoCountriesForUnmatchedQuery() {
        XCTAssertTrue(controller.countries(matching: "not-a-country").isEmpty)
    }

    func testRapidSequentialQueriesImmediatelyUseLatestResults() {
        controller.searchController.searchBar.text = "united"
        controller.updateSearchResults(for: controller.searchController)
        XCTAssertEqual(controller.filteredCountries.map(\.code), ["US", "GB"])

        controller.searchController.searchBar.text = "fr"
        controller.updateSearchResults(for: controller.searchController)
        XCTAssertEqual(controller.filteredCountries.map(\.code), ["FR"])
    }
}

#endif
