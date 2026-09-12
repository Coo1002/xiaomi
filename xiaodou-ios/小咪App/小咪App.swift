import SwiftUI

@main
struct XiaoMiApp: App {
    var body: some Scene {
        WindowGroup {
            PetWebView()
                .ignoresSafeArea(.all)
                .statusBarHidden(true)
        }
    }
}
