//
//  TipTextfieldView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 12.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct TipTextfieldView: View {
    @Binding var textValue: String?
    @State var placeHolder: String
    @Binding var error: String?
    @State var active: Bool = false
    
    private enum Config {
        static let cornerRadius: CGFloat = 8.0
        static let textfieldHeight: CGFloat = 52.0
        static let padding: CGFloat = 20.0
        static let lineWidth: CGFloat = 2.0
        static let errorOffset: CGFloat = 4.0
        static let height: CGFloat = 18.0
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: Config.cornerRadius)
                    .fill(AppColors.white5)
                    .frame(maxWidth: .infinity)
                    .frame(height: Config.textfieldHeight)
                
                Text(placeHolder)
                    .font((textValue == "" || textValue == nil ) ? FontStyle.normal.font : FontStyle.normalSmall.font)
                    .foregroundColor(AppColors.white40)
                    .padding(.horizontal)
                    .padding(.top, (textValue == "" || textValue == nil ) ? 0 : -Config.padding)
                    .animation(.linear, value: UUID())
                TextField("", text: $textValue.toUnwrapped(defaultValue: ""), onEditingChanged: { editingChanged in
                    
                    if editingChanged {
                        active = true
                    } else {
                        active = false
                    }
                })
                .onChange(of: textValue) { newValue in
                    error  = nil
                }
                .textFieldStyle(.plain)
                .padding(.horizontal)
                .foregroundColor(AppColors.white)
                .font(FontStyle.normalInput.font)
                .textFieldStyle(.roundedBorder)
                .padding(.top, (textValue == "" || textValue == nil ) ? 0 : Config.padding)
                .animation(.linear, value: UUID())
                
            }
            .frame(height: Config.textfieldHeight)
            .overlay(
                RoundedRectangle(cornerRadius: Config.cornerRadius)
                    .stroke(AppColors.actionPremium, lineWidth: (active == false || error != nil) ? 0 : Config.lineWidth)
                    .animation(.linear, value: UUID())
            )
            .overlay(
                RoundedRectangle(cornerRadius: Config.cornerRadius)
                    .stroke(AppColors.redError, lineWidth: error == nil ? 0 : Config.lineWidth)
                    .animation(.linear, value: UUID())
            )
            if error != nil {
                Spacer().frame(height: Config.errorOffset)
                HStack {
                    Text(error ?? "")
                        .font(FontStyle.error.font)
                        .frame(minHeight: Config.height)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(AppColors.redError)
                        .opacity(error == nil ? 0 : 1)
                        .animation(.linear, value: UUID())
                    Spacer()
                }
            }
        }
    }
}

struct TipTextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            TipTextfieldView( textValue: .constant(nil), placeHolder: "", error: .constant(nil), active: false)
        }
        
    }
}
