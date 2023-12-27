//
//  IdeasView.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI

struct IdeasView: View {
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Ideas")
                        .foregroundColor(.white)
                        .font(.system(size: 23, weight: .semibold))
                    
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .center, spacing: 10, content: {
                    
                    Text("!")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold))
                        .frame(width: 30, height: 30)
                        .background(Circle().fill(.red))
                    
                    Text("For add any ideas, you need to add 25 members of your team")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                .padding(.horizontal)
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
    }
}

#Preview {
    IdeasView()
}
