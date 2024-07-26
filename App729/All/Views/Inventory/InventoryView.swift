//
//  InventoryView.swift
//  App729
//
//  Created by IGOR on 24/07/2024.
//

import SwiftUI

struct InventoryView: View {
    
    @StateObject var viewModel = InventoryViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                
                Text("Inventory")
                    .foregroundColor(Color("prim"))
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    HStack {
                        
                        Text("\(viewModel.items)")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 22, weight: .bold))
                            .padding(10)
                            .background(Rectangle().fill(.white.opacity(0.2)))
                        
                        Text("items have been added to the inventory")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                 
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 18, weight: .medium))
                            .frame(width: 55, height: 80)
                            .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                    })
                }
                
                HStack {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAddCat = true
                                }
                                
                            }, label: {
                                
                                Image(systemName: "pencil")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .padding(13)
                                    .padding(.horizontal)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.gray.opacity(0.7)))
                            })
                            
                            ForEach(viewModel.categories, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.currentCat = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                        .foregroundColor(viewModel.currentCat == index ? .black : .gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .padding(11)
                                        .padding(.horizontal)
                                        .background(RoundedRectangle(cornerRadius: 8).fill(viewModel.currentCat == index ? Color("prim") : .gray.opacity(0.7)))

                                })
                            }
                        }
                    }
                    .frame(height: 35)
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        ForEach(viewModel.inventories.filter{($0.inCat ?? "") == viewModel.currentCat}, id: \.self) { index in
                        
                            HStack {
                                
                                VStack {
                                    
                                    Image(index.inPhoto ?? "")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                 
                                    Spacer()
                                    
                                }
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    Text(index.inName ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                        .padding(.bottom, 6)
                                    
                                    Text("Stamp: \(index.inStamp ?? "")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Text("Model: \(index.inModel ?? "")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Text("Size: \(index.inSize ?? "")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Text("Start date: \(index.inSD ?? "")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack {
                                    
                                    Text(index.inCat ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 11, weight: .regular))
                                        .padding(4)
                                        .padding(.horizontal, 6)
                                        .background(RoundedRectangle(cornerRadius: 5).fill(Color("prim")))
                                 
                                    Spacer()
                                    
                                }
                            }
                            .padding()
                            .frame(height: 145)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                        }
                    }
                }
                
                
                
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddInv(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddCat ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddCat = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Add a new category")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()

                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.carToAdd.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.carToAdd)
                            .foregroundColor(Color.white)
                            .font(.system(size: 14, weight: .semibold))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))

                    HStack {
                        
                        Button(action: {
                            
                            viewModel.categories.append(viewModel.carToAdd)
                            
                            viewModel.carToAdd = ""
                   
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = false
                                
                            }
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(.green)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                            
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddCat = false
                            }
                            
                        }, label: {
                            
                            Text("Close")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                            
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                .offset(y: viewModel.isAddCat ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchInventories()
        }
    }
}

#Preview {
    InventoryView()
}
