//
//  NavigationMenu.swift
//  GenericViews
//
//  Created by Toka Elkeik on 06/06/2024.
//

import SwiftUI

import SwiftUI

struct MenuItem {
    var text: String
    var aboveImageSelected: Image?
    var aboveImageUnSelected: Image?
    var inLineImageSelected: Image?
    var inLineImageUnselected: Image?
}

// MARK: - NavigationMenu
struct NavigationMenu: View {
    
    @Binding var selectedIndex: Int
    var menuItems: [MenuItem]
    var isScrollable: Bool
    @Environment(\.menuConfiguration) var configuration
    var actionHandler: ((Int) -> Void)?
    
    var body: some View {
        HStack {
            if isScrollable {
                ScrollViewReader { value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        MenuView(menuItems: menuItems,
                                 selectedIndex: $selectedIndex,
                                 configuration: configuration)
                    }.onAppear {
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
struct MenuView: View {
    @Namespace private var menuItemTransition
    var menuItems: [MenuItem]
    @Binding var selectedIndex: Int
    var configuration: MenuConfiguration
    var actionHandler: ((Int) -> Void)?
    
    @Namespace var namespace
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            ForEach(Array(menuItems.enumerated()), id: \.offset) { index, menu in
                Spacer().frame(width: configuration.margin)
                if configuration.isUnderLined {
                    UnderlinedMenuItemView(selectedIndex: $selectedIndex,
                                           menu: menu,
                                 isSelected: index == selectedIndex,
                                 configuration: configuration,
                                 action: {
                                     selectedIndex = index
                                     actionHandler?(index)
                                 }, nameSpace: namespace)
                } else {
                    MenuItemView(selectedIndex: $selectedIndex,
                                 menu: menu,
                                 isSelected: index == selectedIndex,
                                 configuration: configuration,
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
            RoundedRectangle(cornerRadius: configuration.itemCornerRadius)
                .foregroundColor(configuration.menuBackgroundColor)
        )
    }
}

// MARK: - MenuItemView
struct MenuItemView: View {
    @Binding var selectedIndex: Int
    var menu: MenuItem
    var isSelected: Bool
    var configuration: MenuConfiguration
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
        
            
            HStack(spacing: 0) {
                if let image = isSelected ? menu.inLineImageSelected : menu.inLineImageUnselected {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: configuration.imageWidth)
                        .padding(.trailing, configuration.imagePadding)
                }
                Text(menu.text)
                    .foregroundColor(isSelected ? configuration.menuSelectedItemTextColor : configuration.unselectedTextColor)
                    .font(isSelected ? configuration.selectedFont : configuration.unselectedFont)
            }
            .padding(.horizontal, configuration.itemPadding)
            .overlay(
                RoundedRectangle(cornerRadius: configuration.itemCornerRadius)
                    .stroke(isSelected ? configuration.selectedBorderColor : configuration.unselectedBorderColor, lineWidth: configuration.itemBorderWidth)
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

// MARK: - UnderlinedMenuItemView
struct UnderlinedMenuItemView: View {
    @Binding var selectedIndex: Int
    var menu: MenuItem
    var isSelected: Bool
    var configuration: MenuConfiguration
    var action: () -> Void
    let nameSpace: Namespace.ID

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if let aboveImage = isSelected ? menu.aboveImageSelected : menu.aboveImageUnSelected {
                aboveImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: configuration.imageWidth)
                    .padding(.bottom, configuration.imagePadding)
            }
            Text(menu.text)
                .foregroundColor(isSelected ? configuration.menuSelectedItemTextColor : configuration.unselectedTextColor)
                .font(isSelected ? configuration.selectedFont : configuration.unselectedFont)
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


// MARK: - Preview
struct NavigationMenu_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            NavigationMenu(selectedIndex: .constant(2),
                           menuItems: [
                            MenuItem(text: "Item 1",
                                     aboveImageSelected: Image(systemName: "star.fill"),
                                     aboveImageUnSelected: Image(systemName: "star")),
                            MenuItem(text: "Item 2"),
                            MenuItem(text: "Item 3", inLineImageSelected: Image(systemName: "checkmark"), inLineImageUnselected: Image(systemName: "xmark"))
                           ], isScrollable: false)
        }.frame(maxWidth: .infinity)
    }
}

// MARK: - Environment
struct MenuConfiguration {
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
    var isUnderLined: Bool = false
    var underlineColor: Color = .black
    var underlineTopPadding: CGFloat = 20
    var underlineHeight: CGFloat = 3
    var imageWidth: CGFloat = 30
    var imagePadding: CGFloat = 10
    var margin: CGFloat = 5
}

// MARK: - Environment Keys
private struct MenuConfigurationKey: EnvironmentKey {
    
    static let defaultValue = MenuConfiguration(
        outerViewHeight: 48,
        innerViewHeight: 40,
        itemPadding: 12,
        menuBackgroundColor: .clear,
        selectedMenuItemBackgroundColor: .clear,
        unselectedMenuItemBackgroundColor: .clear,
        menuSelectedItemTextColor: .black,
        unselectedTextColor: .blue,
        itemBorderWidth: 1,
        itemCornerRadius: 5,
        selectedBorderColor: .clear,
        unselectedBorderColor: .clear,
        isMaxWidth: false,
        selectedFont: .body,
        unselectedFont: .caption,
        isUnderLined: false,
        underlineColor: .black,
        underlineTopPadding: 20,
        underlineHeight: 3,
        imageWidth: 30,
        imagePadding: 10,
        margin: 5
    )
}

// MARK: - Environment Keys
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
