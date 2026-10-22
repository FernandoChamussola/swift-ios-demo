
import SwiftUI

@main
struct SwiftDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "iphone.gen3")
                .font(.system(size: 64))
                .foregroundStyle(.blue)

            Text("Minha aplicação iOS")
                .font(.largeTitle.bold())

            Text("Swift + SwiftUI")
                .font(.title3)
                .foregroundStyle(.secondary)

            Text("A funcionar no simulador!")
                .padding()
                .background(.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
    }
}
