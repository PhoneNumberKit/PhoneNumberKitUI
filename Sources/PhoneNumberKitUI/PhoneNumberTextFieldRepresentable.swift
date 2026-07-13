import SwiftUI

/// A SwiftUI wrapper around ``PhoneNumberTextField``.
public struct PhoneNumberTextFieldRepresentable: UIViewRepresentable {
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
