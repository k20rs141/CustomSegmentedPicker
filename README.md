# CustomSegmentedPicker
CustomSegmentedControl in SwiftUI

## 概要
SwiftUIでカスタムなSegmented Controlを実装。
SwiftUIの標準であるPickerにはないバッジを設定することができる実装となってます。

| Segmented Styleバー | 下線タブバー |
| :-----------: | :-----------: |
| <img src="https://github.com/user-attachments/assets/97186fc8-1671-4e0b-97fd-2d72bca797f6" width="50%"> | <img src="https://github.com/user-attachments/assets/02cf1b2a-c88a-4b79-8273-574088ad9bd5" width="50%"> |

## 開発環境
- Xcode 15.4
- Swift 5.9
- iOS 17.5


## 使い方
badgeCaseにはバッジを付けたいタブのみcaseを宣言するようにする。  
backgroundColor（背景色）, selectedSegmentTintColor（選択されているタブの色）, badgeColor（バッジ色）はデフォルト値が設定されているため省略可能。  
下線タブバー（CustomSegmentedTab）ではfixedをfalseにすることでタブがスクロール可能になり、borderTopをfalseにすることで下線バーを下に移動することも出来る。

```swift
enum TabType: String, CaseIterable, Hashable {
    case normal = "通常"
    case limitedTime = "期間限定"
    case completed = "達成済み"
}

struct ContentView: View {
    @State private var selectedTab: TabType = .normal
    private var items: [TabType] = TabType.allCases
    private var badgeCase: [TabType] = [.normal, .completed]

    var body: some View {
        VStack {
            // Segmented Styleバー
            CustomSegmentedPicker(
                selection: $selectedTab,
                items: items,
                badgeCase: badgeCase,
                backgroundColor: Color(.systemGray5),
                selectedSegmentTintColor: Color(.tintColor),
                badgeColor: .red,
                segmentedWidth: UIScreen.main.bounds.width * 0.95
            ) { tab in
                Text(tab.rawValue)
            }
            Text("Selected Tab: \(selectedTab.rawValue)")
                .font(.title2)
                .padding()

            // 下線タブバー
            CustomSegmentedTab(
                selection: $selectedTab,
                tabs: items,
                badgeCase: badgeCase,
                fixed: true,
                backgroundColor: Color(.systemGray5),
                selectedSegmentTintColor: Color(.tintColor),
                badgeColor: .red,
                geoWidth: UIScreen.main.bounds.width,
                borderTop: false
            ) { tab in
                Text(tab.rawValue)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}

```
