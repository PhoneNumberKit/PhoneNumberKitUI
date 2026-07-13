# PhoneNumberKitUI

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/PhoneNumberKit/PhoneNumberKitUI/pr.yml?branch=main&label=tests&style=for-the-badge)

UIKit components for [PhoneNumberKit](https://github.com/PhoneNumberKit/PhoneNumberKit) — an
auto-formatting `PhoneNumberTextField` and a country-code picker. iOS only.

These components were part of PhoneNumberKit through 4.x. As of the 5.0 reboot they live in this
separate package so the core parsing/formatting library stays UI-free and usable on
server-side Swift, watchOS, and Linux.

## Installation

Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/PhoneNumberKit/PhoneNumberKitUI", from: "1.0.0")
]
```

`PhoneNumberKitUI` depends on `PhoneNumberKit`, which is resolved automatically.

## Usage

```swift
import PhoneNumberKit
import PhoneNumberKitUI

let textField = PhoneNumberTextField()
```

`PhoneNumberTextField` formats as you type and gives full editing capabilities. Customize via:

- `withFlag` — show the current region's flag in the left view.
- `withExamplePlaceholder` — show an example number for the current region (and, with `withPrefix`,
  auto-insert/remove the country prefix).
- `withDefaultPickerUI` — present the country-code picker; configure it via `CountryCodePicker`
  (common codes, modal presentation, search bar) and `CountryCodePickerOptions` (colors, fonts, cells).

```swift
CountryCodePicker.commonCountryCodes = ["US", "GB", "FR"]
textField.withDefaultPickerUIOptions.backgroundColor = .systemBackground
```

### SwiftUI

Use `PhoneNumberTextFieldRepresentable` to bind a text field to SwiftUI state. Configure the
underlying `PhoneNumberTextField` in the trailing closure:

```swift
import SwiftUI
import PhoneNumberKitUI

struct ContentView: View {
    @State private var phoneNumber = ""

    var body: some View {
        PhoneNumberTextFieldRepresentable(text: $phoneNumber) { textField in
            textField.withFlag = true
            textField.withPrefix = true
            textField.withExamplePlaceholder = true
            textField.withDefaultPickerUI = true
        }
    }
}
```

Override the default region by subclassing:

```swift
class MyGBTextField: PhoneNumberTextField {
    override var defaultRegion: String {
        get { "GB" }
        set {}
    }
}
```

Open `Examples/Examples.xcworkspace` for runnable demos — `AsYouType`, `PhoneBook`, and
`CustomCountryPickerCells` — each wired to this package via a local Swift Package reference.

## Acknowledgements

The UI components were originally created by **Roy Marmelstein** as part of PhoneNumberKit.
Maintained by **Bruno Guidolim** and contributors under the PhoneNumberKit organization.

## License

MIT. See [LICENSE](LICENSE).
