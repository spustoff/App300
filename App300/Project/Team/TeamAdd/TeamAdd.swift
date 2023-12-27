//
//  TeamAdd.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI

struct TeamAdd: View {
    
    @StateObject var viewModel: TeamViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New member")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 16, weight: .regular))
                                
                                Text("Back")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 16, weight: .regular))
                            }
                        })
                        
                        Spacer()
                    }
                }
                .padding()
                .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(spacing: 25) {
                        
                        HStack {
                            
                            Text("Nickname")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.nickname.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.nickname)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        .overlay (
                        
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white.opacity(0.3))
                        )
                        
                        HStack {
                            
                            Text("Name")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.name.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        .overlay (
                        
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white.opacity(0.3))
                        )
                        
                        HStack {
                            
                            Text("Subscribers")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.subscribers.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.subscribers)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        .overlay (
                        
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white.opacity(0.3))
                        )
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.addMember()
                    viewModel.fetchTeams()
                    router.wrappedValue.dismiss()
                    
                }, label: {
                    
                    Text("Add")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        .padding()
                })
                .opacity(viewModel.nickname.isEmpty || viewModel.name.isEmpty || viewModel.subscribers.isEmpty ? 0.5 : 1)
                .disabled(viewModel.nickname.isEmpty || viewModel.name.isEmpty || viewModel.subscribers.isEmpty ? true : false)
            }
        }
    }
}

#Preview {
    TeamAdd(viewModel: TeamViewModel())
}
