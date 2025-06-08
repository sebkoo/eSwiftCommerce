//
//  MainTabView.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ProductListView()
                .tabItem {
                    Label("Products", systemImage: "list.dash")
                }
            // Additional tabs to be added in future sprints
        }
    }
}

#Preview {
    MainTabView()
}
