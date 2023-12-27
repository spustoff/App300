//
//  TeamView.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI

struct TeamView: View {
    
    @StateObject var viewModel = TeamViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 6, content: {
                        
                        Text("Number of players")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .semibold))
                        
                        Text("\(viewModel.teams.count)")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    })
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6, content: {
                        
                        Text("Subscribers")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .semibold))
                        
                        Text("\(viewModel.teams.map(\.subscribers).reduce(0, +))")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    })
                }
                .padding()
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                .padding()
                
                HStack {
                    
                    Text("Team")
                        .foregroundColor(.white)
                        .font(.system(size: 23, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.isAdd = true
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 21, weight: .semibold))
                    })
                }
                .padding(.horizontal)
                
                if viewModel.teams.isEmpty {
                    
                    Text("Add your team members")
                        .foregroundColor(.gray)
                        .font(.system(size: 19, weight: .regular))
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            
                            ForEach(viewModel.teams, id: \.self) { index in
                                
                                VStack(spacing: 15) {
                                    
                                    Circle()
                                        .fill(.gray.opacity(0.1))
                                        .frame(width: 65, height: 65)
                                        .overlay(
                                        
                                            Image(systemName: "camera")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 12, weight: .regular))
                                        )
                                    
                                    Text(index.nickname ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .medium))
                                    
                                    HStack {
                                        
                                        VStack(alignment: .center, spacing: 5, content: {
                                            
                                            Text("Name")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 12, weight: .medium))
                                            
                                            Text(index.name ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14, weight: .semibold))
                                        })
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .center, spacing: 5, content: {
                                            
                                            Text("Subscribers")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 12, weight: .medium))
                                            
                                            Text("\(index.subscribers)")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14, weight: .semibold))
                                        })
                                    }
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchTeams()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            TeamAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    TeamView()
}
