//
//  MainSceneView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 17.04.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MainSceneView: View {
    @State var viewModel: MainSceneViewModel
    
    private enum Config {
        static let verticalSpacing: CGFloat = 14.0
        static let cornerRadius: CGFloat = 10.0
        static let sideOffset: CGFloat = 16.0
    }

        var body: some View {
            NavigationView {
                ZStack {
                    VStack {
                        Spacer()
                        Color.yellow.padding()
                        Spacer()
                    }
                    List {
                        Text("First item")
                        Text("Second item")
                        Text("Third item")
                    }
                    .navigationBarTitle("Title", displayMode: .inline)
                    .background(Color.blue)
                    .navigationBarColor(.orange)
                    .edgesIgnoringSafeArea(.bottom)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            TabView {
                                Text("First Tab")
                                    .tabItem {
                                        Label("First", systemImage: "1.circle")
                                    }
                                Text("Second Tab")
                                    .tabItem {
                                        Label("Second", systemImage: "2.circle")
                                    }
                            }
                        }
                    }
                }
            }
        }
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    
    init(backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

struct MainSceneView_Previews: PreviewProvider {
    static var previews: some View {
        MainSceneView(viewModel: MainSceneViewModel())
    }
}
