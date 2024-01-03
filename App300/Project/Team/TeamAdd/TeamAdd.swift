//
//  TeamAdd.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI
import UIKit_design

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
                        
                        TextFieldCustom(text: $viewModel.nickname, placeholderText: "Enter", isStrokeLight: true, isOverlay: true, isHeaderText: true, isDeleteButton: true, isOverlayRectangle: true, headerText: "Nickname", overlayStrokeLightColor: Color("primary"), overlayStrokeColor: .gray.opacity(0.8))
                        
                        TextFieldCustom(text: $viewModel.name, placeholderText: "Enter", isStrokeLight: true, isOverlay: true, isHeaderText: true, isDeleteButton: true, isOverlayRectangle: true, headerText: "Name", overlayStrokeLightColor: Color("primary"), overlayStrokeColor: .gray.opacity(0.8))
                        
                        TextFieldCustom(text: $viewModel.subscribers, placeholderText: "Enter", isStrokeLight: true, isOverlay: true, isHeaderText: true, isDeleteButton: true, isOverlayRectangle: true, isDecimalPad: true, headerText: "Subscribers", overlayStrokeLightColor: Color("primary"), overlayStrokeColor: .gray.opacity(0.8))
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
