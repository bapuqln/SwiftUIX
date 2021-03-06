//
// Copyright (c) Vatsal Manot
//

#if swift(>=5.3) && (os(iOS) || os(macOS) || os(tvOS) || targetEnvironment(macCatalyst))

import Swift
import SwiftUI

@available(iOS 14.0, OSX 10.16, tvOS 14.0, *)
@available(watchOS, unavailable)
@usableFromInline
struct PerformActionOnKeyboardShortcut: ViewModifier {
    let shortcut: KeyboardShortcut
    let action: () -> Void
    
    @usableFromInline
    init(shortcut: KeyboardShortcut, action: @escaping () -> ()) {
        self.shortcut = shortcut
        self.action = action
    }
    
    @available(iOS 14.0, OSX 10.16, tvOS 14.0, *)
    @available(watchOS, unavailable)
    @usableFromInline
    func body(content: Content) -> some View {
        ZStack {
            Button(action: action) {
                EmptyView()
            }
            .keyboardShortcut(shortcut)
            
            content
        }
    }
}

extension View {
    @available(iOS 14.0, OSX 10.16, tvOS 14.0, *)
    @available(watchOS, unavailable)
    @inlinable
    public func onKeyboardShortcut(
        _ shortcut: KeyboardShortcut,
        perform action: @escaping () -> Void
    ) -> some View {
        modifier(PerformActionOnKeyboardShortcut(shortcut: shortcut, action: action))
    }
    
    @available(iOS 14.0, OSX 10.16, tvOS 14.0, *)
    @available(watchOS, unavailable)
    @inlinable
    public func onKeyboardShortcut(
        _ key: KeyEquivalent,
        modifiers: EventModifiers = [],
        perform action: @escaping () -> Void
    ) -> some View {
        modifier(PerformActionOnKeyboardShortcut(shortcut: .init(key, modifiers: modifiers), action: action))
    }
}

#endif
