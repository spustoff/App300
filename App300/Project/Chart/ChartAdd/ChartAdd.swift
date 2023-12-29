//
//  ChartAdd.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI

struct ChartAdd: View {
    
    @StateObject var viewModel: ChartViewModel
    @StateObject var teamModel = TeamViewModel()
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New stream")
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
                        
                        HStack {
                            
                            Text("Start stream")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                            
                            DatePicker(selection: $viewModel.start_stream, displayedComponents: .hourAndMinute, label: {})
                                .labelsHidden()
                            
                            Spacer()
                        }
                        
                        HStack {
                            
                            Text("End stream")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                            
                            DatePicker(selection: $viewModel.end_stream, displayedComponents: .hourAndMinute, label: {})
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
                        
                        HStack {
                            
                            Text("Game")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.game.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.game)
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
                    }
                    .padding([.horizontal, .bottom])
                }
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.addStream()
                    viewModel.fetchCharts()
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
                .opacity(viewModel.streamer.isEmpty ? 0.5 : 1)
                .disabled(viewModel.streamer.isEmpty ? true : false)
            }
        }
        .onAppear {
            
            teamModel.fetchTeams()
        }
    }
}

#Preview {
    ChartAdd(viewModel: ChartViewModel())
}
