import SwiftUI

struct CustomSegmentedTab<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    @Binding var selection: SelectionValue

    private var tabs: [SelectionValue]
    private var fixed: Bool
    private var badgeCase: [SelectionValue]
    private var backgroundColor: Color
    private var selectedSegmentTintColor: Color
    private var badgeColor: Color
    private var geoWidth: CGFloat
    private var borderTop: Bool
    private var content: (SelectionValue) -> Content

    init(
        selection: Binding<SelectionValue>,
        tabs: [SelectionValue],
        badgeCase: [SelectionValue],
        fixed: Bool = true,
        backgroundColor: Color = Color(UIColor.systemGray5),
        selectedSegmentTintColor: Color = Color(UIColor.tintColor),
        badgeColor: Color = .red,
        geoWidth: CGFloat,
        borderTop: Bool,
        @ViewBuilder content: @escaping (SelectionValue) -> Content
    ) {
        self._selection = selection
        self.tabs = tabs
        self.fixed = fixed
        self.badgeCase = badgeCase
        self.backgroundColor = backgroundColor
        self.selectedSegmentTintColor = selectedSegmentTintColor
        self.badgeColor = badgeColor
        self.geoWidth = geoWidth
        self.borderTop = borderTop
        self.content = content
    }

    var body: some View {
        let tabCount = CGFloat(tabs.count)
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(tabs, id: \.self) { tab in
                            Button {
                                withAnimation {
                                    selection = tab
                                }
                            } label: {
                                VStack(spacing: 0) {
                                    if borderTop {
                                        Rectangle()
                                            .fill(selection == tab ? selectedSegmentTintColor : Color.clear)
                                            .frame(height: 3)
                                    }
                                    ZStack(alignment: .topTrailing) {
                                        content(tab)
                                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(selection == tab ? selectedSegmentTintColor : Color(UIColor.systemGray))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 4)
                                        if selection != tab && badgeCase.contains(tab) {
                                            Circle()
                                                .fill(badgeColor)
                                                .frame(width: 10, height: 10)
                                        }
                                    }
                                    .frame(width: fixed ? (geoWidth / tabCount) : .none, height: 40)

                                    if !borderTop {
                                        Rectangle()
                                            .fill(selection == tab ? selectedSegmentTintColor : Color.clear)
                                            .frame(height: 3)
                                    }
                                }
                                .fixedSize()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onChange(of: selection) { _, newValue in
                        withAnimation {
                            proxy.scrollTo(newValue)
                        }
                    }
                }
            }
        }
        .frame(height: 40)
        .onAppear {
            UIScrollView.appearance().backgroundColor = .systemGray5
            UIScrollView.appearance().bounces = fixed ? false : true
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
}

#Preview {
    let tabs: [TabType] = TabType.allCases
    return CustomSegmentedTab(
        selection: .constant(TabType.normal),
        tabs: tabs,
        badgeCase: [.normal, .limitedTime],
        fixed: false,
        backgroundColor: Color(UIColor.systemGray5),
        selectedSegmentTintColor: .blue,
        badgeColor: .red,
        geoWidth: UIScreen.main.bounds.width,
        borderTop: true
    ) { tab in
        Text(tab.rawValue)
    }
}
