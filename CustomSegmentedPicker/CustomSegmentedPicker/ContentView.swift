import SwiftUI

enum TabType: String, CaseIterable, Hashable {
    case normal = "通常"
    case limitedTime = "期間限定"
    case completed = "達成済み"
}

struct ContentView: View {
    @State private var selectedTab: TabType = .normal
    @State private var items: [TabType] = TabType.allCases
    @State private var badgeCase: [TabType] = [.normal, .completed]

    var body: some View {
        VStack {
            CustomSegmentedPicker(
                selection: $selectedTab,
                items: $items,
                badgeCase: $badgeCase,
                backgroundColor: .white,
                selectedSegmentTintColor: .cyan,
                badgeColor: .red,
                segmentedWidth: UIScreen.main.bounds.width * 0.95
            ) { tab in
                Text(tab.rawValue)
            }
            Text("Selected Tab: \(selectedTab.rawValue)")
                .font(.title2)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
