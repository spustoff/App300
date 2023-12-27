//
//  PaymentView.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI

struct PaymentView: View {

    @StateObject var viewModel = PaymentViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Payments")
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
                
                HStack {
                    
                    VStack(alignment: .center, spacing: 6, content: {
                        
                        Text("Earned all the time")
                            .foregroundColor(.white.opacity(0.6))
                            .font(.system(size: 13, weight: .semibold))
                        
                        Text("$\(viewModel.payments.map(\.earned).reduce(0, +))")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    })
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                .padding([.horizontal, .top])
                
                NavigationLink(destination: {
                    
                    PaymentChart()
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Text("EUR/USD >")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.1)))
                        .padding([.horizontal, .bottom])
                })
                
                if viewModel.payments.isEmpty {
                    
                    Text("Nothing payments added")
                        .foregroundColor(.gray)
                        .font(.system(size: 19, weight: .regular))
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.payments, id: \.self) { index in
                            
                                VStack(alignment: .center, spacing: 15, content: {
                                    
                                    Text("$\(index.earned)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .medium))
                                    
                                    Rectangle()
                                        .fill(Color("primary"))
                                        .frame(height: 1)
                                    
                                    HStack(alignment: .bottom, content: {
                                        
                                        VStack(alignment: .leading, spacing: 5, content: {
                                            
                                            Text(index.streamer ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .regular))
                                            
                                            Text(index.payment_type ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                        })
                                        
                                        Spacer()
                                        
                                        Text((index.date_stream ?? Date()).convertDate(format: "MMM d"))
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13, weight: .regular))
                                    })
                                })
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchPayments()
        }
    }
}

#Preview {
    PaymentView()
}
