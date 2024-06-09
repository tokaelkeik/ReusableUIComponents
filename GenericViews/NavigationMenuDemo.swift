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
            ChipMenuExample()
            Spacer().frame(height: 50)
            ChipMenuWithImageExample()
            Spacer().frame(height: 50)
            FloatingMenuCellExample()
            Spacer().frame(height: 50)
            UnderlinedMenuWithImage()
            Spacer().frame(height: 50)
            UnderlinedMenuExample()
            Spacer().frame(height: 50)
            UnderlinedMenuWithInlineImage()
            Spacer()
        }
    }
}


// MARK: - ChipMenuExample
struct ChipMenuExample: View {
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
        .menuConfiguration(ChipMenuConfiguration(
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


// MARK: - FloatingMenuCellExample
struct FloatingMenuCellExample: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "Heart FILLED",
                                          imageSelected: Image(systemName: "heart.fill"),
                                          imageUnselected: Image(systemName: "heart.fill")),
                                 MenuItem(text: "Location",
                                          imageSelected: Image(systemName: "location"),
                                          imageUnselected: Image(systemName: "location"))]
    var body: some View {
        HStack {
            Text("Inline with text")
            
            Spacer()
            NavigationMenu(selectedIndex: $selectedIndex,
                           menuItems: menuItems,
                           isScrollable: false)
            .menuConfiguration(ChipMenuConfiguration(
                outerViewHeight: 60,
                innerViewHeight: 48,
                itemPadding: 15,
                menuBackgroundColor: .gray,
                selectedMenuItemBackgroundColor: .white,
                menuSelectedItemTextColor: .black,
                unselectedTextColor: Color(hex: 0xC8C8C8),
                itemCornerRadius: 30,
                selectedFont: .system(size: 12, weight: .bold),
                unselectedFont: .system(size: 12, weight: .regular),
                imageWidth: 15,
                unSelectedImageOpacity: 0.1,
                imagePosition: .above
            )
            )
            
        }.padding(.horizontal, 10)
        
    }
}


// MARK: - ChipMenuWithImageExample
struct ChipMenuWithImageExample: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "1 Star",
                                          imageSelected: Image(systemName: "star"),
                                          imageUnselected: Image(systemName: "star")),
                                 MenuItem(text: "2 Stars",
                                          imageSelected: Image(systemName: "star"),
                                          imageUnselected: Image(systemName: "star")),
                                 MenuItem(text: "3 Stars",
                                          imageSelected: Image(systemName: "star"),
                                          imageUnselected: Image(systemName: "star")),
                                 MenuItem(text: "4 Stars",
                                          imageSelected: Image("starSelected"),
                                          imageUnselected:Image(systemName: "star"))
    ]
    var body: some View {
        NavigationMenu(selectedIndex: $selectedIndex,
                       menuItems: menuItems,
                       isScrollable: true)
        .menuConfiguration(ChipMenuConfiguration(
            innerViewHeight: 30,
            itemPadding: 6,
            selectedMenuItemBackgroundColor: .gray,
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


// MARK: UnderlinedMenuWithImage
struct UnderlinedMenuWithImage: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "Bookmark",
                                          imageSelected: Image(systemName: "bookmark"),
                                          imageUnselected: Image(systemName: "bookmark")),
                                 MenuItem(text: "trash",
                                          imageSelected: Image(systemName: "trash"),
                                          imageUnselected: Image(systemName: "trash")),
                                 MenuItem(text: "Phone Numer",
                                          imageSelected: Image(systemName: "phone"),
                                          imageUnselected: Image(systemName: "phone")),
                                 MenuItem(text: "Envelope",
                                          imageSelected: Image(systemName: "envelope"),
                                          imageUnselected: Image(systemName: "envelope")),
                                 MenuItem(text: "Person",
                                          imageSelected: Image(systemName: "person"),
                                          imageUnselected: Image(systemName: "person")),
                                 MenuItem(text: "Paper clip",
                                          imageSelected: Image(systemName: "paperclip"),
                                          imageUnselected: Image(systemName: "paperclip")),
                                 MenuItem(text: "Bandage",
                                          imageSelected: Image(systemName: "bandage"),
                                          imageUnselected: Image(systemName: "bandage"))]
    
    var body: some View {
        
        VStack(spacing: 0) {
            NavigationMenu(selectedIndex: $selectedIndex,
                           menuItems: menuItems,
                           isScrollable: true)
            .menuConfiguration(UnderlineMenuConfiguration(
                outerViewHeight: 90,
                menuSelectedItemTextColor: Color(hex: 0x050A30),
                unselectedTextColor: Color(hex: 0x050A30, alpha: 0.5),
                selectedFont: .system(size: 12, weight: .bold),
                unselectedFont: .system(size: 12, weight: .regular),
                underlineColor: Color(hex: 0x050A30),
                underlineTopPadding: 10,
                underlineHeight: 3,
                margin: 10,
                imagePosition: .above
                
            ))
            
            Rectangle()
                .foregroundColor(Color(hex: 0x050A30, alpha: 0.3))
                .frame(height: 2)
                .padding(.top, -13)
        }
        
    }
}

// MARK: - UnderlinedMenuExample
struct UnderlinedMenuExample: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "About"),
                                 MenuItem(text: "Rankings"),
                                 MenuItem(text: "Scores")]
    var body: some View {
        HStack(alignment: .bottom) {
            NavigationMenu(selectedIndex: $selectedIndex,
                           menuItems: menuItems,
                           isScrollable: false)
            .menuConfiguration(UnderlineMenuConfiguration(
                menuSelectedItemTextColor: Color(hex: 0x000000),
                unselectedTextColor: Color(hex: 0x989898),
                selectedFont: .system(size: 12, weight: .bold),
                unselectedFont: .system(size: 12, weight: .regular),
                underlineColor: .black,
                underlineTopPadding: 10,
                underlineHeight: 3,
                margin: 10
                
            ))
            Spacer()
        }
        .frame(height: 45)
        .frame(maxWidth: .infinity)
        .background(Color(hex: 0xF4F4F4))
    }
}

// MARK: - UnderlinedMenuExample
struct UnderlinedMenuWithInlineImage: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [MenuItem(text: "Heart",
                                          imageSelected: Image(systemName: "heart.fill"),
                                          imageUnselected: Image(systemName: "heart.fill")),
                                 MenuItem(text: "Location",
                                          imageSelected: Image(systemName: "location"),
                                          imageUnselected: Image(systemName: "location")),
                                 MenuItem(text: "Calender",
                                          imageSelected: Image(systemName: "calendar"),
                                          imageUnselected: Image(systemName: "calendar"))]
    var body: some View {
        HStack {
           
            NavigationMenu(selectedIndex: $selectedIndex,
                           menuItems: menuItems,
                           isScrollable: false)
            .menuConfiguration(UnderlineMenuConfiguration(
                itemPadding: 5,
                menuSelectedItemTextColor: Color(hex: 0x000000),
                unselectedTextColor: Color(hex: 0x989898),
                selectedFont: .system(size: 12, weight: .bold),
                unselectedFont: .system(size: 12, weight: .regular),
                underlineColor: .black,
                underlineTopPadding: 10,
                underlineHeight: 3,
                imageWidth: 15,
                margin: 10,
                imagePosition: .inline
                
            ))
            Spacer()
        }
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
