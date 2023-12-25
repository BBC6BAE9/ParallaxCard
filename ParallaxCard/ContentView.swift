//
//  ContentView.swift
//  ParallaxCard
//
//  Created by ihenry on 2023/10/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var offset:CGSize = .zero
    
    var body: some View {
        GeometryReader {
            
            let size = $0.size
            let imageSize = size.width * 0.7
            
            VStack {
             Image("shoe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize)
                    .zIndex(1)
                    .offset(x: 20)
                    .offset(x: offSet2Angle().degrees * 5, y: offSet2Angle(true).degrees * 5)
            Text("NIKE")
                    .font(.system(size: 80))
                       .padding(.top, -120)
                       .padding(.bottom, 50)
                       .zIndex(0)
            }
            .background {
                ZStack(){
                    Rectangle()
                        .fill(.red)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            }
            .rotation3DEffect(offSet2Angle(true),axis: (x: -1, y: 0, z: 0))
            .rotation3DEffect(offSet2Angle(),axis: (x: 1, y: 1, z: 1))
            .scaleEffect(0.9)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.3, blendDuration: 0.32)){
                            offset = .zero
                        }
                    }
            )
        }
    }
    
    func offSet2Angle(_ isVerticle:Bool = false) -> Angle {
        let progress = (isVerticle ? offset.height : offset.width) / (isVerticle ? screenSize.height : screenSize.width)
        return .init(degrees: progress * 10)
    }
    
    var screenSize:CGSize = {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return CGSizeMake(100, 100)
    }()
     
}

#Preview {
    ContentView()
}
