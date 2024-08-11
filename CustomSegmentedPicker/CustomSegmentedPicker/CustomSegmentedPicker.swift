import SwiftUI

struct CustomSegmentedPicker<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    @State private var initial = true
    @Namespace private var pickerTransition
    @Binding var selection: SelectionValue
    
    private var items: [SelectionValue]
    private var badgeCase: [SelectionValue]
    private var backgroundColor: Color
    private var selectedSegmentTintColor: Color
    private var badgeColor: Color
    private var segmentedWidth: CGFloat
    private var content: (SelectionValue) -> Content

    init(
        selection: Binding<SelectionValue>,
        items: [SelectionValue],
        badgeCase: [SelectionValue],
        backgroundColor: Color = Color(UIColor.systemGray5),
        selectedSegmentTintColor: Color = Color(UIColor.link),
        badgeColor: Color = .red,
        segmentedWidth: CGFloat,
        @ViewBuilder content: @escaping (SelectionValue) -> Content
    ) {
        self._selection = selection
        self.items = items
        self.badgeCase = badgeCase
        self.backgroundColor = backgroundColor
        self.selectedSegmentTintColor = selectedSegmentTintColor
        self.badgeColor = badgeColor
        self.segmentedWidth = segmentedWidth
        self.content = content
    }

    var body: some View {
        let tabCount = CGFloat(items.count)
        HStack(spacing: 0) {
            ForEach(items, id: \.self) { tab in
                Button {
                    selection = tab
                    initial = false
//                    withAnimation(.easeInOut(duration: 0.22)) {
//                        selection = tab
//                    }
                } label: {
                    ZStack(alignment: .topTrailing) {
                        content(tab)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 6)
                        if selection != tab && badgeCase.contains(tab) {
                            Circle()
                                .fill(badgeColor)
                                .frame(width: 10, height: 10)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: segmentedWidth / tabCount, height: 32)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(selection == tab ? .white : .secondary)
                .matchedGeometryEffect(id: tab, in: pickerTransition, isSource: true)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 6)
                .matchedGeometryEffect(id: selection, in: pickerTransition, isSource: false)
                .animation(initial ? nil : .easeInOut(duration: 0.22), value: initial)
                .foregroundColor(selectedSegmentTintColor)
                .shadow(color: .black.opacity(0.2), radius: 2)
        )
        .frame(width: segmentedWidth, height: 32)
        .padding(2)
        .background(backgroundColor)
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
    }
}

#Preview {
    let tabs: [TabType] = TabType.allCases
    return CustomSegmentedPicker(
        selection: .constant(TabType.normal),
        items: tabs,
        badgeCase: [.normal, .completed],
        backgroundColor: .white,
        selectedSegmentTintColor: .cyan,
        badgeColor: .red,
        segmentedWidth: UIScreen.main.bounds.width * 0.95
    ) { tab in
        Text(tab.rawValue)
    }
}
