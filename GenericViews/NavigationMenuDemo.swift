//
//  NavigationMenuDemo.swift
//  GenericViews
//
//  Created by Toka Elkeik on 06/06/2024.
//

import SwiftUI

import SwiftUI

struct NavigationMenuDemo: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            PanceMenu()
            Spacer().frame(height: 50)
            InfinityMenu()
            Spacer().frame(height: 50)
            FanzwordMenu()
            Spacer().frame(height: 50)
            BerberShopMenu()
            Spacer().frame(height: 50)
            StarsMenu()
            Spacer()
        }
        
    }
}

// MARK: - PanceMen
struct PanceMenu: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "All"),
                                 MenuItem(text: "Flowers"),
                                 MenuItem(text: "Chocolate"),
                                 MenuItem(text: "Perfumes"),
                                 MenuItem(text: "Cakes"),
                                 MenuItem(text: "Specials")]
    var body: some View {
        NavigationMenu(selectedIndex: $selectedIndex,
                       menuItems: menuItems,
                       isScrollable: true)
        .menuConfiguration(MenuConfiguration(
            innerViewHeight: 46,
            itemPadding: 12,
            selectedMenuItemBackgroundColor: .white,
            unselectedMenuItemBackgroundColor: Color(hex: 0xF8F8F8),
            menuSelectedItemTextColor: Color(hex: 0xB8987D),
            unselectedTextColor: Color(hex: 0x9B9B9B),
            itemBorderWidth: 1,
            itemCornerRadius: 10,
            selectedBorderColor: Color(hex: 0xB8987D),
            selectedFont: .system(size: 12, weight: .bold),
            unselectedFont: .system(size: 12, weight: .regular),
            margin: 5
        )
        )
    }
}

// MARK: - InfinityMenu
struct InfinityMenu: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "About"),
                                 MenuItem(text: "Rankings"),
                                 MenuItem(text: "Scores")]
    var body: some View {
        HStack {
            NavigationMenu(selectedIndex: $selectedIndex,
                           menuItems: menuItems,
                           isScrollable: false)
            .menuConfiguration(MenuConfiguration(
                menuSelectedItemTextColor: Color(hex: 0x000000),
                unselectedTextColor: Color(hex: 0x989898),
                selectedFont: .system(size: 12, weight: .bold),
                unselectedFont: .system(size: 12, weight: .regular),
                isUnderLined: true,
                underlineColor: .black,
                underlineTopPadding: 10,
                underlineHeight: 3,
                margin: 10
                
            ))
            Spacer()
        }
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        .background(Color(hex: 0xF4F4F4))
    }
}

// MARK: - FanzwordMenu
struct FanzwordMenu: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "Predict"),
                                 MenuItem(text: "Fantasy"),
                                 MenuItem(text: "Winners"),
                                 MenuItem(text: "Bonus") ]
    var body: some View {
        NavigationMenu(selectedIndex: $selectedIndex,
                       menuItems: menuItems,
                       isScrollable: false)
        .menuConfiguration(MenuConfiguration(
            outerViewHeight: 50,
            innerViewHeight: 38,
            itemPadding: 12,
            menuBackgroundColor: Color(hex: 202543),
            selectedMenuItemBackgroundColor: .white,
            menuSelectedItemTextColor: .black,
            unselectedTextColor: Color(hex: 0xC8C8C8),
            itemCornerRadius: 25, selectedFont: .system(size: 12, weight: .bold),
            unselectedFont: .system(size: 12, weight: .regular)
        )
        )
    }
}

// MARK: - BerberShopMenu
struct BerberShopMenu: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "Barber Shops",
                                          aboveImageSelected: Image("Beauty"),
                                          aboveImageUnSelected: Image("Beauty")),
                                 MenuItem(text: "Wellness & Spa",
                                          aboveImageSelected: Image("Hair Salon"),
                                          aboveImageUnSelected: Image("Hair Salon")),
                                 MenuItem(text: "Hair Salon",
                                          aboveImageSelected: Image("Scissors"),
                                          aboveImageUnSelected: Image("Scissors")),
                                 MenuItem(text: "Skin Care",
                                          aboveImageSelected: Image("Skin Care"),
                                          aboveImageUnSelected: Image("Skin Care"))]
    
    var body: some View {
        
        VStack(spacing: 0) {
            NavigationMenu(selectedIndex: $selectedIndex,
                           menuItems: menuItems,
                           isScrollable: true)
            .menuConfiguration(MenuConfiguration(
                outerViewHeight: 90,
                innerViewHeight: 90,
                menuSelectedItemTextColor: Color(hex: 0x050A30),
                unselectedTextColor: Color(hex: 0x050A30, alpha: 0.5),
                selectedFont: .system(size: 12, weight: .bold),
                unselectedFont: .system(size: 12, weight: .regular),
                isUnderLined: true,
                underlineColor: Color(hex: 0x050A30),
                underlineTopPadding: 10,
                underlineHeight: 3,
                margin: 30
            
            ))
            
            Rectangle()
                .foregroundColor(Color(hex: 0x050A30, alpha: 0.3))
                .frame(height: 2)
                .padding(.top, -7)
        }
        
    }
}

// MARK: - StartsMenu
struct StarsMenu: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "1 Star",
                                          inLineImageSelected: Image("starSelected"),
                                          inLineImageUnselected: Image("starUnSelected")),
                                 MenuItem(text: "2 Stars",
                                          inLineImageSelected: Image("starSelected"),
                                          inLineImageUnselected: Image("starUnSelected")),
                                 MenuItem(text: "3 Stars",
                                          inLineImageSelected: Image("starSelected"),
                                          inLineImageUnselected: Image("starUnSelected")),
                                 MenuItem(text: "4 Stars",
                                          inLineImageSelected: Image("starSelected"),
                                          inLineImageUnselected: Image("starUnSelected")),
                                ]
    var body: some View {
        NavigationMenu(selectedIndex: $selectedIndex,
                       menuItems: menuItems,
                       isScrollable: true)
        .menuConfiguration(MenuConfiguration(
            innerViewHeight: 30,
            itemPadding: 6,
            selectedMenuItemBackgroundColor: Color(hex: 0x050A30),
            unselectedMenuItemBackgroundColor: Color(hex: 0xF8F8F8),
            menuSelectedItemTextColor: .white,
            unselectedTextColor: Color(hex: 0x9B9B9B),
            itemCornerRadius: 10,
            selectedFont: .system(size: 12, weight: .bold),
            unselectedFont: .system(size: 12, weight: .regular),
            imageWidth: 15,
            imagePadding: 4,
            margin: 5
        )
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationMenuDemo()
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
