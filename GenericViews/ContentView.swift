//
//  ContentView.swift
//  GenericViews
//
//  Created by Toka Elkeik on 06/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            CustomPageControl(totalIndex: 5, selectedIndex: selectedIndex)
                .pageControlConfiguration(PageControlConfiguration(
                    selectedColor: .blue,
                    unselectedColor: .gray,
                    selectedSize: CGSize(width: 20, height: 10),
                    unselectedSize: CGSize(width: 12, height: 12),
                    cornerRadius: 10,
                    animation: .spring()
                ))
            
            Button("Next") {
                selectedIndex = (selectedIndex + 1) % 5
            }
        }
    }
    
}

#Preview {
    ContentView()
}
