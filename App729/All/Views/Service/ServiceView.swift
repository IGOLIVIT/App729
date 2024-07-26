//
//  ServiceView.swift
//  App729
//
//  Created by IGOR on 24/07/2024.
//

import SwiftUI

struct ServiceView: View {

    @StateObject var viewModel = ServiceViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                
                Text("Service")
                    .foregroundColor(Color("prim"))
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                       Button(action: {
                           
                           withAnimation(.spring()) {
                               
                               viewModel.isAddInventory = true
                           }
                           
                       }, label: {
                           
                           Image(systemName: "plus")
                               .foregroundColor(Color("prim"))
                               .font(.system(size: 18, weight: .medium))
                               .frame(width: 55, height: 80)
                               .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                       })
                    
                    HStack {

                        Text("Keep your inventory clean")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .semibold))
                            .padding()
                        
                        Image("chel")
                            .resizable()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))

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
                            
                            VStack(spacing: 8) {
                        
                                HStack {
                                    
                                    VStack {
                                        
                                        Image(index.inPhoto ?? "")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                        
                                        Spacer()
                                        
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        
                                        Text(index.inCat ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 11, weight: .regular))
                                            .padding(4)
                                            .padding(.horizontal, 6)
                                            .background(RoundedRectangle(cornerRadius: 5).fill(Color("prim")))
                                        
                                        Text(index.inName ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .semibold))
                                            .padding(.bottom, 6)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    VStack {
                                        
                                        Button(action: {
                                            
                                            viewModel.selectedInventory = index
                                            
                                            withAnimation(.spring()) {
                                                
                                                viewModel.isAdd = true
                                            }
                                            
                                        }, label: {
                                            
                                            Image(systemName: "pencil")
                                                .foregroundColor(Color("prim"))
                                                .font(.system(size: 16, weight: .regular))
                                        })
                                        
                                        Spacer()
                                    }
                                }
                                
                                ForEach(viewModel.records.filter{($0.recInv ?? "") == (index.inName ?? "")}, id: \.self) { indexer in
                                
                                    HStack {
                                        
                                        Text(indexer.recName ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Rectangle()
                                            .fill(Color("prim"))
                                            .frame(width: 1, height: 20)
                                        
                                        Text(indexer.recDate ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 11, weight: .regular))
                                            .padding(5)
                                            .padding(.horizontal, 5)
                                            .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                    }
                                    .padding(12)
                                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                        }
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddRec(viewModel: viewModel)
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
        .onAppear {
            
            viewModel.fetchRecords()
        }
        .sheet(isPresented: $viewModel.isAddInventory, content: {
            
            AddInv(viewModel: InventoryViewModel())
        })
    }
}

#Preview {
    ServiceView()
}
