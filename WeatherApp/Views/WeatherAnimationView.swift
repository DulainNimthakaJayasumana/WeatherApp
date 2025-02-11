//
//  WeatherAnimationView.swift
//  WeatherApp
//
//  Created by Dulain Jayasumana on 2025-02-07.
//

import SwiftUI

struct WeatherAnimationView: View {
    let weatherCondition: String
    
    var body: some View {
        ZStack {
            switch weatherCondition.lowercased() {
            case "rain":
                RainAnimationView()
            case "cloudy", "overcast", "mostly cloudy":
                CloudAnimationView()
            case "clear":
                SunAnimationView()
            default:
                EmptyView()
            }
        }
    }
}

// A simple rain animation.
struct RainAnimationView: View {
    @State private var dropOffset: CGFloat = -100
    
    var body: some View {
        GeometryReader { geo in
            ForEach(0..<20, id: \.self) { i in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 5, height: 10)
                    .position(x: CGFloat.random(in: 0...geo.size.width), y: dropOffset)
                    .animation(
                        Animation.linear(duration: 1.5)
                            .repeatForever(autoreverses: false)
                            .delay(Double(i) * 0.1),
                        value: dropOffset
                    )
            }
            .onAppear {
                dropOffset = geo.size.height + 100
            }
        }
    }
}

// A simple cloud animation.
struct CloudAnimationView: View {
    @State private var offset: CGFloat = -200
    
    var body: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .frame(width: 100, height: 60)
            .foregroundColor(.white)
            .offset(x: offset, y: 0)
            .onAppear {
                withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                    offset = 200
                }
            }
    }
}

// A simple sun animation.
struct SunAnimationView: View {
    @State private var scale: CGFloat = 0.8
    
    var body: some View {
        Image(systemName: "sun.max.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(.yellow)
            .scaleEffect(scale)
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: scale)
            .onAppear {
                scale = 1.2
            }
    }
}

struct WeatherAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAnimationView(weatherCondition: "rain")
    }
}
