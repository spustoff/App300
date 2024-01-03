//
//  PaymentAdd.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI
import UIKit_design

struct PaymentAdd: View {
    
    @Environment(\.presentationMode) var router
    
    @StateObject var viewModel: PaymentViewModel
    @StateObject var teamModel = TeamViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New payments")
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
                            
                            Text("Date stream")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                            
                            DatePicker(selection: $viewModel.date_stream, displayedComponents: .date, label: {})
                                .labelsHidden()
                            
                            Spacer()
                        }
                        
                        Menu {
                            
                            ForEach(teamModel.teams.map(\.name), id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.streamer = index ?? ""
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Text(index ?? "")
                                        
                                        Spacer()
                                        
                                        if viewModel.streamer == index {
                                            
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                })
                            }
                            
                        } label: {
                            
                            HStack {
                                
                                Text("Streamer")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .medium))
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text(viewModel.streamer.isEmpty ? "Choose" : viewModel.streamer)
                                        .foregroundColor(viewModel.streamer.isEmpty ? .gray : .white)
                                        .font(.system(size: 15, weight: .regular))
                                })
                                
                                Spacer()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            .overlay (
                            
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.white.opacity(0.3))
                            )
                        }
                        
                        TextFieldCustom(text: $viewModel.earned, placeholderText: "$", isStrokeLight: true, isOverlay: true, isHeaderText: true, isDeleteButton: true, isOverlayRectangle: true, isDecimalPad: true, headerText: "Earned", overlayStrokeLightColor: Color("primary"), overlayStrokeColor: .gray.opacity(0.8))
                        
                        TextFieldCustom(text: $viewModel.payment_type, placeholderText: "Enter", isStrokeLight: true, isOverlay: true, isHeaderText: true, isDeleteButton: true, isOverlayRectangle: true, headerText: "Payment Type", overlayStrokeLightColor: Color("primary"), overlayStrokeColor: .gray.opacity(0.8))
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.addPayment()
                    viewModel.fetchPayments()
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
                .opacity(viewModel.streamer.isEmpty || viewModel.earned.isEmpty || viewModel.payment_type.isEmpty ? 0.5 : 1)
                .disabled(viewModel.streamer.isEmpty || viewModel.earned.isEmpty || viewModel.payment_type.isEmpty ? true : false)
            }
        }
        .onAppear {
            
            teamModel.fetchTeams()
        }
    }
}

#Preview {
    PaymentAdd(viewModel: PaymentViewModel())
}
