import SwiftUI

enum TabType: String, CaseIterable, Hashable {
    case normal = "通常"
    case limitedTime = "期間限定"
    case completed = "達成済み"
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
