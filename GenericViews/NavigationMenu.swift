//
//  NavigationMenu.swift
//  GenericViews
//
//  Created by Toka Elkeik on 06/06/2024.
//

import SwiftUI

// MARK: - MenuItemProtocol
protocol MenuItemProtocol {
    var text: String { get }
    var selectedImage: Image? { get }
    var unselectedImage: Image? { get }
}

// MARK: - MenuItem
struct MenuItem: MenuItemProtocol {
    var text: String
    var imageSelected: Image?
    var imageUnselected: Image?

    var selectedImage: Image? {
        return imageSelected
    }
    
    var unselectedImage: Image? {
        return imageUnselected
    }
}

// MARK: - NavigationMenu
struct NavigationMenu<Item: MenuItemProtocol>: View {
    @Binding var selectedIndex: Int
    var menuItems: [Item]
    var isScrollable: Bool
    @Environment(\.menuConfiguration) var configuration: MenuConfiguration
    var actionHandler: ((Int) -> Void)?
    
    var body: some View {
        HStack {
            if isScrollable {
                ScrollViewReader { value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        MenuView(menuItems: menuItems,
                                 selectedIndex: $selectedIndex,
                                 configuration: configuration)
                    }
                    .onAppear {
                        withAnimation {
                            value.scrollTo(selectedIndex, anchor: .center)
                        }
                    }
                    .onChange(of: selectedIndex) { index in
                        withAnimation {
                            value.scrollTo(index, anchor: .center)
                        }
                    }
                }
            } else {
                MenuView(menuItems: menuItems,
                         selectedIndex: $selectedIndex,
                         configuration: configuration)
            }
        }
    }
}

// MARK: - MenuView

struct MenuView<Item: MenuItemProtocol>: View {
    @Namespace private var menuItemTransition
    var menuItems: [Item]
    @Binding var selectedIndex: Int
    var configuration: MenuConfiguration
    var actionHandler: ((Int) -> Void)?
    
    @Namespace var namespace
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(Array(menuItems.enumerated()), id: \.offset) { index, menu in
                Spacer().frame(width: configuration.margin)
                if let config = configuration as? UnderlineMenuConfiguration {
                    UnderlinedMenuItemView(selectedIndex: $selectedIndex,
                                           menu: menu,
                                           isSelected: index == selectedIndex,
                                           configuration: config,
                                           action: {
                        selectedIndex = index
                        actionHandler?(index)
                    }, nameSpace: namespace)
                } else if let config = configuration as? ChipMenuConfiguration {
                    ChipMenuItemView(selectedIndex: $selectedIndex,
                                     menu: menu,
                                     isSelected: index == selectedIndex,
                                     configuration: config,
                                     action: {
                        selectedIndex = index
                        actionHandler?(index)
                    }, nameSpace: namespace)
                }
            }
            Spacer().frame(width: configuration.margin)
        }
        .frame(height: configuration.outerViewHeight)
        .background(
            RoundedRectangle(cornerRadius: configuration is ChipMenuConfiguration ? (configuration as! ChipMenuConfiguration).itemCornerRadius : 0)
                .foregroundColor(configuration.menuBackgroundColor)
        )
    }
}

// MARK: - UnderlinedMenuItemView
struct UnderlinedMenuItemView<Item: MenuItemProtocol>: View {
    @Binding var selectedIndex: Int
    var menu: Item
    var isSelected: Bool
    var configuration: UnderlineMenuConfiguration
    var action: () -> Void
    let nameSpace: Namespace.ID
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            MenuItemContentView(menu: menu, isSelected: isSelected,
                                configuration: configuration)
            
            if isSelected {
                configuration.underlineColor
                    .frame(height: configuration.underlineHeight)
                    .padding(.top, configuration.underlineTopPadding)
                    .matchedGeometryEffect(id: "underline",
                                           in: nameSpace,
                                           properties: .frame)
            } else {
                Color.clear
                    .frame(height: configuration.underlineHeight)
                    .padding(.top, configuration.underlineTopPadding)
            }
        }
        .onTapGesture {
            action()
        }
        .fixedSize(horizontal: true, vertical: false)
        .animation(.spring, value: selectedIndex)
    }
}

// MARK: - ChipMenuItemView
struct ChipMenuItemView<Item: MenuItemProtocol>: View {
    @Binding var selectedIndex: Int
    var menu: Item
    var isSelected: Bool
    var configuration: ChipMenuConfiguration
    var action: () -> Void
    let nameSpace: Namespace.ID
    
    var body: some View {
        ZStack {
            if isSelected {
                RoundedRectangle(cornerRadius: configuration.itemCornerRadius)
                    .foregroundColor(configuration.selectedMenuItemBackgroundColor)
                    .frame(height: configuration.innerViewHeight)
                    .matchedGeometryEffect(id: "underline",
                                           in: nameSpace,
                                           properties: .frame)
                
            } else {
                RoundedRectangle(cornerRadius: configuration.itemCornerRadius)
                    .foregroundColor(configuration.unselectedMenuItemBackgroundColor)
                    .frame(height: configuration.innerViewHeight)
            }
            
            MenuItemContentView(menu: menu,
                                isSelected: isSelected,
                                configuration: configuration)
                .overlay(
                    RoundedRectangle(cornerRadius: configuration.itemCornerRadius)
                        .stroke(isSelected ? configuration.selectedBorderColor : configuration.unselectedBorderColor,
                                lineWidth: configuration.itemBorderWidth)
                        .frame(height: configuration.innerViewHeight)
                )
                .onTapGesture {
                    action()
                }
                .frame(maxWidth: configuration.isMaxWidth ? .infinity : .none)
        }
        .fixedSize(horizontal: true, vertical: false)
        .animation(.easeInOut, value: selectedIndex)
    }
}


// MARK: - MenuItemContentView
struct MenuItemContentView<Item: MenuItemProtocol>: View {
    var menu: Item
    var isSelected: Bool
    var configuration: any MenuConfiguration // Use a generic configuration
    
    var body: some View {
        Group {
            if configuration.imagePosition == .inline {
                HStack(spacing: 0) {
                    menuImage()
                    menuText()
                }
                .padding(.horizontal, configuration.itemPadding)
            } else if configuration.imagePosition == .above {
                VStack(spacing: 0) {
                    menuImage()
                    menuText()
                }
                .padding(.horizontal, configuration.itemPadding)
            }
        }
    }
    
    @ViewBuilder
    private func menuImage() -> some View {
        if let image = isSelected ? menu.selectedImage : menu.unselectedImage {
            image
                .resizable()
                .scaledToFit()
                .frame(width: configuration.imageWidth)
                .padding(.trailing, configuration.imagePosition == .inline ?
                         configuration.imagePadding : 0)
                .padding(.bottom, configuration.imagePosition == .above ? configuration.imagePadding : 0)
                .opacity(isSelected ? 1 : configuration.unSelectedImageOpacity)
        }
    }
    
    private func menuText() -> some View {
        Text(menu.text)
            .foregroundColor(isSelected ? configuration.menuSelectedItemTextColor : configuration.unselectedTextColor)
            .font(isSelected ? configuration.selectedFont : configuration.unselectedFont)
    }
}

// MARK: - Preview
struct NavigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            NavigationMenu(selectedIndex: .constant(2),
                           menuItems: [
                            MenuItem(text: "Item 1",
                                     imageSelected: Image(systemName: "star.fill"),
                                     imageUnselected: Image(systemName: "star")),
                            MenuItem(text: "Item 2"),
                            MenuItem(text: "Item 3",
                                     imageSelected: Image(systemName: "checkmark"),
                                     imageUnselected: Image(systemName: "xmark"))
                           ], isScrollable: false)
                .menuConfiguration(UnderlineMenuConfiguration())
        }.frame(maxWidth: .infinity)
    }
}

// MARK: - ImagePosition Enum
enum ImagePosition {
    case above
    case inline
}

// MARK: - MenuConfiguration
protocol MenuConfiguration {
    var outerViewHeight: CGFloat { get }
    var itemPadding: CGFloat { get }
    var menuBackgroundColor: Color { get }
    var menuSelectedItemTextColor: Color { get }
    var unselectedTextColor: Color { get }
    var selectedFont: Font { get }
    var unselectedFont: Font { get }
    var imageWidth: CGFloat { get }
    var imagePadding: CGFloat { get }
    var margin: CGFloat { get }
    var unSelectedImageOpacity: CGFloat { get }
    var imagePosition: ImagePosition{ get }
}

// MARK: - UnderlineMenuConfiguration
struct UnderlineMenuConfiguration: MenuConfiguration {
    var outerViewHeight: CGFloat = 48
    var itemPadding: CGFloat = 12
    var menuBackgroundColor: Color = .clear
    var menuSelectedItemTextColor: Color = .black
    var unselectedTextColor: Color = .blue
    var selectedFont: Font = .system(size: 16, weight: .bold)
    var unselectedFont: Font = .system(size: 16, weight: .regular)
    var underlineColor: Color = .black
    var underlineTopPadding: CGFloat = 20
    var underlineHeight: CGFloat = 3
    var imageWidth: CGFloat = 30
    var imagePadding: CGFloat = 10
    var margin: CGFloat = 5
    var unSelectedImageOpacity: CGFloat = 0.5
    var imagePosition: ImagePosition = .above
}

// MARK: - ChipMenuConfiguration
struct ChipMenuConfiguration: MenuConfiguration {
    var outerViewHeight: CGFloat = 48
    var innerViewHeight: CGFloat = 40
    var itemPadding: CGFloat = 12
    var menuBackgroundColor: Color = .clear
    var selectedMenuItemBackgroundColor: Color = .clear
    var unselectedMenuItemBackgroundColor: Color = .clear
    var menuSelectedItemTextColor: Color = .black
    var unselectedTextColor: Color = .blue
    var itemBorderWidth: CGFloat = 1
    var itemCornerRadius: CGFloat = 5
    var selectedBorderColor: Color = .clear
    var unselectedBorderColor: Color = .clear
    var isMaxWidth: Bool = false
    var selectedFont: Font = .system(size: 16, weight: .bold)
    var unselectedFont: Font = .system(size: 16, weight: .regular)
    var imageWidth: CGFloat = 30
    var imagePadding: CGFloat = 10
    var margin: CGFloat = 5
    var unSelectedImageOpacity: CGFloat = 0.5
    var imagePosition: ImagePosition = .inline
}

// MARK: - Environment Keys
private struct MenuConfigurationKey: EnvironmentKey {
    static let defaultValue: MenuConfiguration = ChipMenuConfiguration() // Default configuration
}

extension EnvironmentValues {
    var menuConfiguration: MenuConfiguration {
        get { self[MenuConfigurationKey.self] }
        set { self[MenuConfigurationKey.self] = newValue }
    }
}

extension View {
    func menuConfiguration(_ configuration: MenuConfiguration) -> some View {
        environment(\.menuConfiguration, configuration)
    }
}

// MARK: - Add conditional modifiers
extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
}
