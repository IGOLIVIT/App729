//
//  AddRec.swift
//  App729
//
//  Created by IGOR on 24/07/2024.
//

import SwiftUI

struct AddRec: View {
    
    @StateObject var viewModel: ServiceViewModel
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
                        
                        
                        viewModel.fetchInventories()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = false
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 16, weight: .medium))
                    })
                    
                }
                .padding(.vertical)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 8) {
                        
                        Text("Inventory")
                            .foregroundColor(.white)
                            .font(.system(size: 26, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            LazyHStack {
                                
                                ForEach(viewModel.inventories, id: \.self) { index in
                                    
                                    Button(action: {
                                        
                                        viewModel.selectedInventory = index
                                        
                                    }, label: {
                                        
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
                                            
                                            
                                        }
                                        .padding()
                                        .frame(width: 260, height: 130)
                                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim").opacity(viewModel.selectedInventory == index ? 1 : 0)))
                                        .padding(1)
                                    })
                                }
                            }
                        }
                        
                        HStack {
                            
                            Text("Records")
                                .foregroundColor(.white)
                                .font(.system(size: 26, weight: .bold))
                            
                            Spacer()
                            
                            Button(action: {
                                
                                viewModel.recInv = viewModel.selectedInventory?.inName ?? ""
                                
                                viewModel.addRecord()
                                
                                viewModel.recName = ""
                                viewModel.recDate = ""
                                
                                viewModel.fetchRecords()
                                
                            }, label: {
                                
                                Image(systemName: "plus")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 18, weight: .medium))
                            })
                            .opacity(viewModel.recName.isEmpty || viewModel.recDate.isEmpty ? 0.5 : 1)
                            .disabled(viewModel.recName.isEmpty || viewModel.recDate.isEmpty ? true : false)
                        }
                        .padding(.vertical)
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 7) {
                                
                                Text("Name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .medium))
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Text")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.recName.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.recName)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                                .padding(1)
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 7) {
                                
                                Text("Date")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .medium))
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Text")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.recDate.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.recDate)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                                .padding(1)
                            }
                        }
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.records, id: \.self) { index in
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading, spacing: 7) {
                                            
                                            Text("Name")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .medium))
                                            
                                            Text(index.recName ?? "")
                                                .foregroundColor(Color.white)
                                                .font(.system(size: 14, weight: .semibold))
                                                .padding()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                                                .padding(1)
                                            
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 7) {
                                            
                                            Text("Date")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .medium))
                                            
                                            Text(index.recDate ?? "")
                                                .foregroundColor(Color.white)
                                                .font(.system(size: 14, weight: .semibold))
                                                .padding()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                                                .padding(1)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchInventories()
        }
        .onAppear {
            
            viewModel.fetchRecords()
        }
    }
}

#Preview {
    AddRec(viewModel: ServiceViewModel())
}
