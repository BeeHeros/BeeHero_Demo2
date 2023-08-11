//
//  HiveView.swift
//  BeeHero
//
//  Created by 洪铭锟 on 2023/8/8.
//

import SwiftUI
import UIKit



struct HiveColors {
    static let beeModeGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 1, green: 0.88, blue: 0.27), location: 0.00),
            Gradient.Stop(color: Color(red: 1, green: 0.65, blue: 0.13), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.05, y: 0.09),
        endPoint: UnitPoint(x: 0.91, y: 1)
    )
    static let plantModeGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.6, green: 0.88, blue: 0.28), location: 0.00),
            Gradient.Stop(color: Color(red: 0.15, green: 0.73, blue: 0.3), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.05, y: 0.09),
        endPoint: UnitPoint(x: 0.91, y: 1)
    )
    static let beeBgGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .white, location: 0.00),
            Gradient.Stop(color: Color(red: 1, green: 0.98, blue: 0.9), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
    static let plantBgGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.96, green: 1, blue: 0.91), location: 0.00),
            Gradient.Stop(color: .white, location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.54, y: 1),
        endPoint: UnitPoint(x: 0.54, y: 0)
    )
    
    
}



struct HiveView: View {
    
   // @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   // let settings = HiveSettings()
    @EnvironmentObject var settings: HiveSettings
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea(.all)
            HiveBackgroundView()//.environmentObject(HiveSettings())
            ScrollHiveView()//.environmentObject(HiveSettings())
            HiveTopView()//.environmentObject(HiveSettings())
            
            VStack(spacing: 0){
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 60)
                ModeToggleView()//.environmentObject(HiveSettings())
            }
               
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HiveView_Previews: PreviewProvider {
    static var previews: some View {
        HiveView().environmentObject(HiveSettings())
    }
}

struct HiveBackgroundView: View{
    
    @EnvironmentObject var settings: HiveSettings
    
    var body: some View {
        
        HiveColors.beeBgGradient
            .ignoresSafeArea(.all)
            .opacity(settings.currentMode == .beeMode ? 1 : 0)
       
        HiveColors.plantBgGradient
            .ignoresSafeArea(.all)
            .opacity(settings.currentMode == .beeMode ? 0 : 1)
        
    }
    
}

struct HiveTopView: View {
    
    @EnvironmentObject var settings: HiveSettings
   // @State private var shouldNavigateBack: Bool? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        if settings.currentMode == .beeMode {
                            HiveColors.beeModeGradient
                        } else {
                            HiveColors.plantModeGradient
                        }
                    }
                }
                .frame(height: geometry.safeAreaInsets.top + 44)
                .edgesIgnoringSafeArea(.top)  // 忽略顶部的安全区
            }
            HStack{
                Spacer()
                Text("蜂巢")
                    .fontWeight(.medium)
                    .foregroundColor(Color("TextBrown"))
                    .font(.title2)
                Spacer()
                
                    
            }.frame(maxWidth: .infinity, maxHeight: 44)
            
            HStack{
                Button {
                    settings.showHive.toggle()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("TextBrown"))
                        .padding(.leading)
                        .font(.title)
                }

                
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: 44)
            
        }
    }
}

struct ModeToggleView: View {
    
    @EnvironmentObject var settings: HiveSettings
    

    var body: some View {
        let buttonWidth: CGFloat = 130
        let buttonHeight: CGFloat = 40
        
        let computedHighlightOffset: CGFloat = settings.highlightOffset ?? (settings.currentMode == .beeMode ? 0 : 110)

        VStack{
            ZStack(alignment: .leading){
                // ... (rest of the code remains unchanged)
                RoundedRectangle(cornerRadius: 20)
                    .fill(settings.currentMode == .beeMode ? Color("BeeLightOrange") : Color("PlantLightGreen"))
                    .frame(width: 240, height: buttonHeight)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 1, y: 2)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                       .fill(HiveColors.beeModeGradient)
                       .frame(width: buttonWidth, height: buttonHeight)
                       .offset(x: computedHighlightOffset)
                       .opacity(settings.currentMode == .beeMode ? 1 : 0)
                    RoundedRectangle(cornerRadius: 20)
                       .fill(HiveColors.plantModeGradient)
                       .frame(width: buttonWidth, height: buttonHeight)
                       .offset(x: computedHighlightOffset)
                       .opacity(settings.currentMode == .beeMode ? 0 : 1)
                }
                // ... (rest of the code remains unchanged)
                
                HStack(spacing: 0){
                    Text("花蜜")
                        .foregroundColor(settings.currentMode == .beeMode ? Color.white : Color("TextBrown") )
                        .fontWeight(.bold)
                        .frame(width: buttonWidth, height: buttonHeight)
                        .onTapGesture {
                            withAnimation {
                                settings.currentMode = .beeMode
                                settings.highlightOffset = 0
                            }
                        }
                    Text("种子")
                        .foregroundColor(settings.currentMode == .plantMode ? Color.white : Color("TextBrown") )
                        .fontWeight(.bold)
                        .offset(x: 240 - buttonWidth * 2)
                        .frame(width: buttonWidth, height: buttonHeight)
                        .onTapGesture {
                            withAnimation {
                                settings.currentMode = .plantMode
                                settings.highlightOffset = 240 - buttonWidth
                            }
                        }
                }
            }
        }
    }
}

struct Flower {
    var name: String
    var progress: Double // 花蜜收集进度, 例如: 0.7 表示70%
    var imageName: String // 花的照片的资源名称
    // 其他你需要的属性，例如颜色、描述等
}

struct HiveUnitView: View{
    
    @State private var waveOffset: CGFloat = 0.0
    @State private var waveHeight: CGFloat = 20
    
    var body: some View {
        let gradientBee = LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 1, green: 0.88, blue: 0.27).opacity(0.8), location: 0.00),
                Gradient.Stop(color: Color(red: 1, green: 0.66, blue: 0.14).opacity(0.8), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
        ZStack {
            Image("HiveUnit")
                .shadow(color: .black.opacity(0.17), radius: 11, x: 0, y: 0)
            
            BeeWave(animatableData: waveOffset)
                .fill(gradientBee)
                .frame(height: 50)
                .mask{
                    Image("HiveUnitMask")
                }
                .animation(Animation.linear(duration: 16).repeatForever(autoreverses: false), value: waveOffset)
                .onAppear() {
                    self.waveOffset += 1
                }
            
            Image("Daisy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(x: -1)
                .frame(width:170)
                .offset(x: -50)
                
        }
    }
}

struct BeeWave: Shape {
    
    var animatableData: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for i in stride(from: 0, to: rect.width, by: 1) {
            let randomOffset = CGFloat.random(in: 0...0)
            let yOffset = sin(((i / rect.width) + animatableData) * (4 * .pi)) * (12 + randomOffset)
            if i == 0 {
                path.move(to: CGPoint(x: i, y: yOffset))
            } else {
                path.addLine(to: CGPoint(x: i, y: yOffset))
            }
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }

}

struct ScrollHiveView: View {
    
    @EnvironmentObject var settings: HiveSettings
    
    var body: some View{
        ScrollView(showsIndicators: false){
            
            
            ZStack {
                //Hive Unit
                HStack(alignment: .top, spacing: -68) {
                    VStack(spacing: -25){
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 150)
                        ForEach(0..<5) { index in
                            HiveUnitView()
                        }
                    }
                    VStack(spacing: -25){
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 245)
                        ForEach(0..<5) { index in
                            Image("HiveUnit")
                                .shadow(color: .black.opacity(0.17), radius: 11, x: 0, y: 0)
                        }
                    }
                }.opacity(settings.currentMode == .beeMode ? 1 : 0)
                
                //Seed Unit
                HStack(alignment: .top, spacing: -68) {
                    VStack(spacing: 20){
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 130)
                        ForEach(0..<5) { index in
                            Image("SeedUnit")
                                .shadow(color: .black.opacity(0.17), radius: 11, x: 0, y: 0)
                        }
                    }
                    VStack(spacing: 20){
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 225)
                        ForEach(0..<5) { index in
                            Image("SeedUnit")
                                .shadow(color: .black.opacity(0.17), radius: 11, x: 0, y: 0)
                        }
                    }
                }.opacity(settings.currentMode == .beeMode ? 0 : 1)
                
            }

        }
    }
}
