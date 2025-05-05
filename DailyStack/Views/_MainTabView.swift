//
//  _MainTabView.swift
//  DailyStack
//
//  Created by Robin O'Brien on 2025-05-01.
//

import SwiftUI

struct Tab {
    let id: Int
    let name: String
    let color: Color
    let icon: String
    
    static let tabs: [Tab] = [
        Tab(id: 0, name: "Home", color: .blue, icon: "house"),
        Tab(id: 1, name: "Search", color: .green, icon: "magnifyingglass"),
        Tab(id: 2, name: "Profile", color: .red, icon: "person")
    ]
}


struct _MainTabView: View {
    let tabs = Tab.tabs
    @State private var selectedTab = 0
    @State var showLoadingScreen = true
    
    var body: some View {
        VStack {
            tabSelectionIcons
            tabViewContent
        }
        .background(.ultraThinMaterial)
        
    }
}



#Preview {
    _MainTabView()
}




extension _MainTabView {
 
    private var tabSelectionIcons: some View {
        HStack {
            Spacer()
            ForEach(tabs, id: \.id) { tab in
                Image(systemName: tab.icon)
                    .font(.system(size:25))
                    .foregroundStyle(tab.id == selectedTab ? tab.color : .gray.opacity(0.7))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            selectedTab = tab.id
                        }
                    }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 45)
    }
    
    
    private var tabViewContent: some View {
        
        TabView(selection: $selectedTab) {
            Tab0View()
                .tag(0)
            
            Tab1View()
                .tag(1)
            
            Tab2View()
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
    
    
}
