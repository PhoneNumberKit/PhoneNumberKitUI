#if os(iOS)
import SwiftUI

/// A SwiftUI wrapper around ``PhoneNumberTextField``.
///
/// The text field and its country code picker (if enabled) use the locale from the SwiftUI environment,
/// which defaults to current and can be overridden using the standard `.environment(\.locale, …)`
/// modifier if needed.
public struct PhoneNumberTextFieldRepresentable: UIViewRepresentable {
    @Environment(\.locale) private var locale: Locale
    @Binding private var text: String
    private let configure: (PhoneNumberTextField) -> Void

    /// Creates a phone number text field bound to a string.
    ///
    /// - Parameters:
    ///   - text: The text displayed and edited by the text field.
    ///   - configure: A closure for configuring the underlying UIKit text field.
    public init(
        text: Binding<String>,
        configure: @escaping (PhoneNumberTextField) -> Void = { _ in }
    ) {
        _text = text
        self.configure = configure
    }

    public func makeUIView(context: Context) -> PhoneNumberTextField {
        let textField = PhoneNumberTextField()
        textField.locale = locale
        configure(textField)
        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.textDidChange(_:)),
            for: .editingChanged
        )
        return textField
    }

    public func updateUIView(_ textField: PhoneNumberTextField, context: Context) {
        context.coordinator.parent = self
        if textField.locale != locale {
            textField.locale = locale
        }

        if textField.text != text {
            textField.text = text
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    public final class Coordinator: NSObject {
        fileprivate var parent: PhoneNumberTextFieldRepresentable

        fileprivate init(parent: PhoneNumberTextFieldRepresentable) {
            self.parent = parent
        }

        @objc fileprivate func textDidChange(_ textField: PhoneNumberTextField) {
            parent.text = textField.text ?? ""
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var phoneNumber: String = ""

    Form {
        PhoneNumberTextFieldRepresentable(text: $phoneNumber) { textField in
            textField.withFlag = true
            textField.withPrefix = true
            textField.withExamplePlaceholder = true
            textField.withDefaultPickerUI = true
        }
    }
    .environment(\.locale, Locale(identifier: "en_US"))
}
#endif
