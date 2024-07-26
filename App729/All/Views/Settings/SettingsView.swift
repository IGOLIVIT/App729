//
//  SettingsView.swift
//  App729
//
//  Created by IGOR on 24/07/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @StateObject var viewModel = InventoryViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Settings")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 25)
                
                Button(action: {
                    
                    SKStoreReviewController.requestReview()
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 17, weight: .regular))
                        
                        Text("Rate Us")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 16, weight: .medium))
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 17, weight: .regular))
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                })
                
                Button(action: {
                    
                    guard let url = URL(string: "https://www.termsfeed.com/live/5cbcec8c-45c6-490a-8fa9-8401cb2488e2") else { return }
                    
                    UIApplication.shared.open(url)
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 17, weight: .regular))
                        
                        Text("Usage Policy")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 16, weight: .medium))
                        
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 17, weight: .regular))
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                })
                
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
