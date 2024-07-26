//
//  AddInv.swift
//  App729
//
//  Created by IGOR on 24/07/2024.
//

import SwiftUI

struct AddInv: View {
    
    @StateObject var viewModel: InventoryViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .regular))
                            
                            Text("Back")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .regular))
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.items += 1
                        
                        viewModel.inPhoto = viewModel.curPhoto
                        viewModel.inCat = viewModel.currentCat
                        
                        viewModel.addInventory()
                        
                        viewModel.inName = ""
                        viewModel.inStamp = ""
                        viewModel.inModel = ""
                        viewModel.inSize = ""
                        viewModel.inSD = ""
                        
                        viewModel.fetchInventories()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = false
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 16, weight: .medium))
                    })
                    .opacity(viewModel.inName.isEmpty || viewModel.inStamp.isEmpty || viewModel.inModel.isEmpty || viewModel.inSize.isEmpty || viewModel.inSD.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.inName.isEmpty || viewModel.inStamp.isEmpty || viewModel.inModel.isEmpty || viewModel.inSize.isEmpty || viewModel.inSD.isEmpty ? true : false)
                }
                .padding(.vertical)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 16) {
                        
                        Menu(content: {
                            
                            ForEach(viewModel.photos, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.curPhoto = index
                                    
                                }, label: {
                                    
                                    Image(index)
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.curPhoto.isEmpty {
                                
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .regular))
                                    .frame(width: 100, height: 100)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.8)))
                                
                            } else {
                                
                                Image(viewModel.curPhoto)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack {
                                    
                                    ForEach(viewModel.categories, id: \.self) { index in
                                        
                                        Button(action: {
                                            
                                            viewModel.currentCat = index
                                            
                                        }, label: {
                                            
                                            Text(index)
                                                .foregroundColor(viewModel.currentCat == index ? .black : .gray)
                                                .font(.system(size: 14, weight: .regular))
                                                .padding(7)
                                                .padding(.horizontal)
                                                .background(RoundedRectangle(cornerRadius: 8).fill(viewModel.currentCat == index ? Color("prim") : .gray.opacity(0.7)))
                                        })
                                    }
                                }
                            }
                            .frame(height: 30)
                        }
                        
                        VStack(alignment: .leading, spacing: 7) {
                            
                            Text("Name")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.inName.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.inName)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .semibold))
                                
                            })
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                            .padding(1)
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 7) {
                            
                            Text("Stamp")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.inStamp.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.inStamp)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .semibold))
                                
                            })
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                            .padding(1)
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 7) {
                            
                            Text("Model")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.inModel.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.inModel)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .semibold))
                                
                            })
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                            .padding(1)
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 7) {
                            
                            Text("Size")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.inSize.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.inSize)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .semibold))
                                
                            })
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                            .padding(1)
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 7) {
                            
                            Text("Start date")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.inSD.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.inSD)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .semibold))
                                
                            })
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                            .padding(1)
                            
                        }
                    }
                }
             }
            .padding()
        }
    }
}

#Preview {
    AddInv(viewModel: InventoryViewModel())
}
