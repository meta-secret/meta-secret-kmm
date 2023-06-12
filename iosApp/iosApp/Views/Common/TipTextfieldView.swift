//
//  TipTextfieldView.swift
//  iosApp
//
//  Created by Dmitry Kuklin on 12.06.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct TipTextfieldView: View {
    @State var nickName: String = ""
    @State var placeHolder: String
    @Binding var error: String
    
    private enum Config {
        static let cornerRadius: CGFloat = 8.0
        static let textfieldHeight: CGFloat = 52.0
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: Config.cornerRadius)
                    .fill(AppColors.white5)
                    .frame(maxWidth: .infinity)
                    .frame(height: Config.textfieldHeight)
                
                Text(placeHolder)
                    .font(nickName == "" ? FontStyle.normal.font : FontStyle.normalSmall.font)
                    .foregroundColor(AppColors.white40)
                    .padding(.horizontal)
                    .padding(.top, nickName == "" ? 0 : -20)
                    .animation(.linear)
                TextField("", text: $nickName)
                    .textFieldStyle(.plain)
                    .padding(.horizontal)
                    .foregroundColor(AppColors.white)
                    .font(FontStyle.normalInput.font)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, nickName == "" ? 0 : 20)
                    .animation(.linear)
                
            }
            .frame(height: Config.textfieldHeight)
            .overlay(
                RoundedRectangle(cornerRadius: Config.cornerRadius)
                    .stroke(AppColors.redError, lineWidth: error.isEmpty ? 0 : 2)
                    .animation(.linear)
            )
            
            Spacer().frame(height: 4.0)
            HStack {
                Text(error)
                    .font(FontStyle.error.font)
                    .frame(minHeight: 18.0)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(AppColors.redError)
                    .opacity(error.isEmpty ? 0 : 1)
                    .animation(.linear)
                Spacer()
            }
        }
    }
}

struct TipTextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            TipTextfieldView( placeHolder: "", error: .constant(""))
        }
        
    }
}
