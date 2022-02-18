import SwiftUI

// MARK: - Public
@available(iOS 15.0, *)
public extension View {
    /// Adds a sheet which respects `UISheetPresentationController` detents.
    ///
    /// Example:
    /// ```
    /// struct ContentView: View {
    ///     @State
    ///     var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium
    ///     var body: some View {
    ///         Button("Toggle Sheet") {
    ///             withAnimation {
    ///                 isSheetPresented.toggle()
    ///             }
    ///         }.detentSheet(isPresented: $isSheetPresented, largestUndimmedDetentIdentifier: .medium, allowsDismissalGesture: true) {
    ///             Text("Sheet View")
    ///         }
    ///     }
    /// }
    /// ```
    /// - Parameters:
    ///   - isPresented: Whether or not the sheet is presented.
    ///   - selectedDetentIdentifier: The identifier of the most recently selected detent.
    ///   - largestUndimmedDetentIdentifier: The largest detent that doesn’t dim the view underneath the sheet.
    ///   - prefersScrollingExpandsWhenScrolledToEdge: A Boolean value that determines whether scrolling expands the sheet to a larger detent.
    ///   - prefersGrabberVisible: A Boolean value that determines whether the sheet shows a grabber at the top.
    ///   - prefersEdgeAttachedInCompactHeight: A Boolean value that determines whether the sheet attaches to the bottom edge of the screen in a compact-height size class.
    ///   - widthFollowsPreferredContentSizeWhenEdgeAttached: A Boolean value that determines whether the sheet's width matches its view controller's preferred content size.
    ///   - preferredCornerRadius: The corner radius that the sheet attempts to present with.
    ///   - detents: The array of heights where a sheet can rest.
    ///   - allowsDismissalGesture: Whether or not the sheet should enable the swipe-to-dismiss gesture.
    ///   - background: The view that displays behind the sheet.
    ///   - sheet: The view that is presented as a sheet.
    /// - Returns: A new view with that wraps the receiver and given sheet.
    func detentSheet<Sheet: View>(isPresented: Binding<Bool>,
                                  selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>? = nil,
                                  largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
                                  prefersScrollingExpandsWhenScrolledToEdge: Bool = true,
                                  prefersGrabberVisible: Bool = false,
                                  prefersEdgeAttachedInCompactHeight: Bool = false,
                                  widthFollowsPreferredContentSizeWhenEdgeAttached: Bool = false,
                                  preferredCornerRadius: CGFloat? = nil,
                                  detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
                                  allowsDismissalGesture: Bool = true,
                                  @ViewBuilder sheet: () -> Sheet) -> some View {
        self.modifier(DetentSheetPresenter(largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
                                           prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                                           prefersGrabberVisible: prefersGrabberVisible,
                                           prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight,
                                           widthFollowsPreferredContentSizeWhenEdgeAttached: widthFollowsPreferredContentSizeWhenEdgeAttached,
                                           preferredCornerRadius: preferredCornerRadius,
                                           detents: detents,
                                           allowsDismissalGesture: allowsDismissalGesture,
                                           selectedDetentIdentifier: selectedDetentIdentifier,
                                           isSheetPresented: isPresented,
                                           sheet: sheet))
    }
}


// MARK: - Internal
@available(iOS 15.0, *)
struct DetentSheetPresenter<Sheet: View>: ViewModifier {
    init(largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?,
         prefersScrollingExpandsWhenScrolledToEdge: Bool,
         prefersGrabberVisible: Bool,
         prefersEdgeAttachedInCompactHeight: Bool,
         widthFollowsPreferredContentSizeWhenEdgeAttached: Bool,
         preferredCornerRadius: CGFloat?,
         detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
         allowsDismissalGesture: Bool,
         selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>?,
         isSheetPresented: Binding<Bool>,
         @ViewBuilder sheet: () -> Sheet) {
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.prefersGrabberVisible = prefersGrabberVisible
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
        self.preferredCornerRadius = preferredCornerRadius
        self.detents = detents
        self.allowsDismissalGesture = allowsDismissalGesture
        self.selectedDetentIdentifier = selectedDetentIdentifier
        self._isSheetPresented = isSheetPresented
        self.sheet = sheet()
    }
    
    func body(content: Content) -> some View {
        DetentSheetStack(isSheetPresented: $isSheetPresented,
                         selectedDetentIdentifier: selectedDetentIdentifier,
                         largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
                         prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                         prefersGrabberVisible: prefersGrabberVisible,
                         prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight,
                         widthFollowsPreferredContentSizeWhenEdgeAttached: widthFollowsPreferredContentSizeWhenEdgeAttached,
                         preferredCornerRadius: preferredCornerRadius,
                         detents: detents,
                         allowsDismissalGesture: allowsDismissalGesture,
                         background: { content },
                         sheet: { sheet })
    }
    
    @Binding
    var isSheetPresented: Bool
    var selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>?
    let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersGrabberVisible: Bool
    let prefersEdgeAttachedInCompactHeight: Bool
    let widthFollowsPreferredContentSizeWhenEdgeAttached: Bool
    let preferredCornerRadius: CGFloat?
    let detents: [UISheetPresentationController.Detent]
    let allowsDismissalGesture: Bool
    let sheet: Sheet
}

// MARK: Wrapping View
@available(iOS 15.0, *)
struct DetentSheetStack<Background: View, Sheet: View>: UIViewControllerRepresentable {
    init(isSheetPresented: Binding<Bool>,
         selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>?,
         largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?,
         prefersScrollingExpandsWhenScrolledToEdge: Bool,
         prefersGrabberVisible: Bool,
         prefersEdgeAttachedInCompactHeight: Bool,
         widthFollowsPreferredContentSizeWhenEdgeAttached: Bool,
         preferredCornerRadius: CGFloat?,
         detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
         allowsDismissalGesture: Bool,
         @ViewBuilder background: () -> Background,
         @ViewBuilder sheet: () -> Sheet) {
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.prefersGrabberVisible = prefersGrabberVisible
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
        self.preferredCornerRadius = preferredCornerRadius
        self.detents = detents
        self.allowsDismissalGesture = allowsDismissalGesture
        self.selectedDetentIdentifier = selectedDetentIdentifier
        self._isSheetPresented = isSheetPresented
        self.background = background()
        self.sheet = sheet()
    }
    
    typealias UIViewControllerType = UIViewController
    
    func makeCoordinator() -> Coordinator<Background, Sheet> {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        configureSheet(context: context)
        context.coordinator.sheetViewController.isModalInPresentation = !allowsDismissalGesture
        return context.coordinator.sheetPresentingViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        configureSheet(context: context)
    }
    
    final class Coordinator<Background: View, Sheet: View>: NSObject, UISheetPresentationControllerDelegate, SheetViewControllerDelegate {
        var parent: DetentSheetStack<Background, Sheet>
        let sheetViewController: SheetViewController<Sheet>
        let sheetPresentingViewController: SheetPresentingViewController<Background>
        
        init(_ sheetPresenter: DetentSheetStack<Background, Sheet>) {
            parent = sheetPresenter
            let sheetHostingController = SheetViewController(rootView: parent.sheet)
            sheetViewController = sheetHostingController
            sheetPresentingViewController = SheetPresentingViewController(rootView: parent.background,
                                                                          shouldSheetBeInitiallyPresented: parent.isSheetPresented,
                                                                          sheetViewController: sheetHostingController)
            super.init()
        }
        
        func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
            parent.selectedDetentIdentifier?.wrappedValue = sheetPresentationController.selectedDetentIdentifier
        }
        
        func sheetViewControllerDidDismiss<Content>(_ sheetViewController: SheetViewController<Content>) where Content : View {
            parent.isSheetPresented = false
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.isSheetPresented = false
        }
    }
    
    @Binding
    var isSheetPresented: Bool
    var selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>?
    let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersGrabberVisible: Bool
    let prefersEdgeAttachedInCompactHeight: Bool
    let widthFollowsPreferredContentSizeWhenEdgeAttached: Bool
    let preferredCornerRadius: CGFloat?
    let detents: [UISheetPresentationController.Detent]
    let allowsDismissalGesture: Bool
    let background: Background
    let sheet: Sheet
    
    private func configureSheet(context: Context) {
        guard let sheetPresentationController = context.coordinator.sheetViewController.sheetPresentationController else { return }
        let animated = context.transaction.animation != nil && !context.transaction.disablesAnimations
        let presentingViewController = context.coordinator.sheetPresentingViewController
        let configure = {
            presentingViewController.navigationController?.isNavigationBarHidden = true
            sheetPresentationController.selectedDetentIdentifier = selectedDetentIdentifier?.wrappedValue
            sheetPresentationController.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
            sheetPresentationController.prefersGrabberVisible = prefersGrabberVisible
            sheetPresentationController.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
            sheetPresentationController.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
            sheetPresentationController.preferredCornerRadius = preferredCornerRadius
            sheetPresentationController.detents = detents
            sheetPresentationController.delegate = context.coordinator
        }
        if animated {
            sheetPresentationController.animateChanges {
                configure()
            }
        } else {
            configure()
        }
        presentingViewController.shouldSheetBeInitiallyPresented = isSheetPresented
        presentingViewController.setSheetPresented(isSheetPresented, animated: animated)
    }
}

// MARK: Supporting UIKit Views
final class SheetPresentingViewController<Content: View>: UIHostingController<Content> {
    let sheetViewController: UIViewController
    var isSheetPresented: Bool { sheetViewController.presentingViewController != nil }
    
    var shouldSheetBeInitiallyPresented: Bool
    
    func setSheetPresented(_ presentSheet: Bool, animated: Bool) {
        guard viewHasAppeared else { return }
        if presentSheet, !isSheetPresented {
            present(sheetViewController, animated: animated, completion: nil)
        } else if !presentSheet, isSheetPresented {
            sheetViewController.dismiss(animated: animated, completion: nil)
        }
    }
    
    init(rootView: Content, shouldSheetBeInitiallyPresented: Bool, sheetViewController: UIViewController) {
        self.shouldSheetBeInitiallyPresented = shouldSheetBeInitiallyPresented
        self.sheetViewController = sheetViewController
        rootView.navigationBarHidden(true)
        super.init(rootView: rootView)
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !viewHasAppeared else { return }
        viewHasAppeared = true
        setSheetPresented(shouldSheetBeInitiallyPresented, animated: animated)
    }
    
    private var viewHasAppeared = false
}

protocol SheetViewControllerDelegate: AnyObject {
    func sheetViewControllerDidDismiss<Content: View>(_ sheetViewController: SheetViewController<Content>)
}

final class SheetViewController<Content: View>: UIHostingController<Content> {
    weak var delegate: SheetViewControllerDelegate?
    
    override init(rootView: Content) {
        super.init(rootView: rootView)
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: animated, completion: completion)
        delegate?.sheetViewControllerDidDismiss(self)
    }
}

// MARK: Preview
#if DEBUG
@available(iOS 15.0, *)
private struct DetentSheetPreviewView: View {
    @State
    var isSheetPresented = true
    
    @State
    var selectedDetentID: UISheetPresentationController.Detent.Identifier? = .medium
    
    var body: some View {
        VStack {
            Spacer()
            Button("Toggle Sheet") {
                withAnimation {
                    isSheetPresented.toggle()
                }
            }
            Spacer()
            Text("Background View")
            Spacer()
        }.detentSheet(isPresented: $isSheetPresented,
                      selectedDetentIdentifier: $selectedDetentID,
                      largestUndimmedDetentIdentifier: .medium,
                      allowsDismissalGesture: true) {
            VStack {
                Spacer()
                Button("Toggle Detent") {
                    withAnimation {
                        selectedDetentID = selectedDetentID == .medium ? .large : .medium
                    }
                }
                Spacer()
                Text("Sheet View")
                Spacer()
            }
            
        }
    }
}

@available(iOS 15.0, *)
struct DetentSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetentSheetPreviewView()
    }
}
#endif
