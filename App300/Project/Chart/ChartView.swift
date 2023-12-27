//
//  ChartView.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI

struct ChartView: View {
    
    @StateObject var viewModel = ChartViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Chart")
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
                .padding()
                
                if viewModel.charts.isEmpty {
                    
                    Text("Nothing planned added")
                        .foregroundColor(.gray)
                        .font(.system(size: 19, weight: .regular))
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.charts, id: \.self) { index in
                                
                                HStack {
                                    
                                    Circle()
                                        .fill(.gray.opacity(0.1))
                                        .frame(width: 41, height: 41)
                                        .overlay(
                                        
                                            Image(systemName: "camera")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 12, weight: .regular))
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 3, content: {
                                        
                                        Text(index.streamer ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15, weight: .regular))
                                        
                                        Text(index.game ?? "")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13, weight: .regular))
                                    })
                                    
                                    Spacer()
                                    
                                    HStack(content: {
                                        
                                        Text((index.start_stream ?? Date()).convertDate(format: "HH:mm"))
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13, weight: .medium))
                                        
                                        Text("-")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13, weight: .medium))
                                        
                                        Text((index.end_stream ?? Date()).convertDate(format: "HH:mm"))
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13, weight: .medium))
                                    })
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchCharts()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            ChartAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    ChartView()
}
