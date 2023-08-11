//
//  BeeHeroTest.swift
//  SwiftLearning
//
//  Created by 洪铭锟 on 2023/8/6.
//

import SwiftUI
import UIKit

struct MainView: View {
    @EnvironmentObject var settings: HiveSettings
    
    @State var imageOffsetY: CGFloat = 0.0
    @State var imageOffsetZ: CGFloat = 1.0
    @State var offsetX: CGFloat = 4.0
    @State var navigateToNextScreen: Bool = false
    
    var body: some View {
      
        ZStack {
           
            Color.white.ignoresSafeArea(.all)
            BackgroundColor()
            VStack {
                TopNavigation()
                   .padding(.top)
               EducationWordsView()
               CenterBeeView(imageOffsetY: $imageOffsetY, imageOffsetZ: $imageOffsetZ)
              
               SlideToBegin(
                    imageOffsetY: $imageOffsetY,
                    imageOffsetZ: $imageOffsetZ,
                    offsetX: $offsetX,
                    navigateToNextScreen: $navigateToNextScreen
               )
               .padding(.top, 20)
              
              Spacer()
           }
            VStack {
                Spacer()
                HoneyWaveView()
            }.ignoresSafeArea()
       }
       .statusBarHidden()
    }
}


struct BeeHeroTest_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(HiveSettings())
    }
}


struct BackgroundColor: View {
    
    @EnvironmentObject var settings: HiveSettings

    var body: some View {
        
        ZStack {
            // Bee Mode Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 1, green: 0.96, blue: 0.75), .white]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .opacity(settings.currentMode == .beeMode ? 1 : 0)

            // Plant Mode Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.84, green: 1, blue: 0.75), .white]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .opacity(settings.currentMode == .beeMode ? 0 : 1)
        }
        .ignoresSafeArea(.all)
        //.animation(.easeInOut(duration: 0.5), value: settings.currentMode)
    }
}



struct TopNavigation: View{
    
    @EnvironmentObject var settings: HiveSettings
    
    var body: some View{
        HStack{
            Button {
            
            } label: {
                Image("Menu")
                
            }
            .padding(.leading, 6.0)
            
            Spacer()
                
            
            Image("BeeHeroText")
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {  // Use withAnimation here
                    if settings.currentMode == .beeMode {
                        settings.currentMode = .plantMode
                        settings.highlightOffset = 110
                    }else{
                        settings.currentMode = .beeMode
                        settings.highlightOffset = 0
                    }
                }
            } label: {
                ZStack{
                    Image("FlowerIconSwitch")
                        .padding(.trailing)
                        .opacity(settings.currentMode == .beeMode ? 1 : 0)
                    Image("BeeIconSwitch")
                        .padding(.trailing)
                        .opacity(settings.currentMode == .beeMode ? 0 : 1)
                }
                
            }
        }
        .padding(.horizontal)
    }
}

struct EducationWordsView: View {
    @State private var educationWords: String = "每制造1千克蜂蜜，蜜蜂飞行距离可绕地球4圈"
    var body: some View{
        VStack{
            Text("你知道吗？")
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.top,15)
                .foregroundColor(Color(red: 0.27, green: 0.17, blue: 0.13).opacity(0.7))
            Text(educationWords)
                .font(.footnote)
                .foregroundColor(Color(red: 0.27, green: 0.17, blue: 0.13).opacity(0.7))
                .padding(.top,1)
                .frame(width: 280)
        }
        
    }
}
struct CenterBeeView: View {
    
    //@StateObject var settings = HiveSettings()
   // @State private var shouldNavigateToHive: Bool = false
    @EnvironmentObject var settings: HiveSettings
    
    @Binding var imageOffsetY: CGFloat
    @Binding var imageOffsetZ: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                ZStack{
                    
                    
                    Image("HivePolygon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.8)
                        .opacity(settings.currentMode == .beeMode ? 1 : 0)
                    
                    
                    Image("PlantHivePolygon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.8)
                        .opacity(settings.currentMode == .beeMode ? 0 : 1)
                        
                   
                  
                    
                    Image("BeeHeroAvatar")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 1.1, height: 450)
                        .offset(y: 50 + imageOffsetY)
                        .opacity(settings.currentMode == .beeMode ? 1 : 0)
                        .mask {
                            Image("HiveMask")
                                .resizable()
                                //.offset(y: 40)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 1)
                        }
                        
                    Image("PlantAvatar")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 1.1, height: 450)
                        .offset(y: 50 + imageOffsetY)
                        .scaleEffect(imageOffsetZ)
                        .opacity(settings.currentMode == .beeMode ? 0 : 1)
                        .mask {
                            Image("HiveMask")
                                .resizable()
                                //.offset(y: 40)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 1)
                        }
                    
                    Button {
                        withAnimation {
                            settings.showHive.toggle()
                        }
                        
                    } label: {
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 300)
                    }

                    
                        
                    
//                    Rectangle()
//                        .fill(Color.clear)
//                        .frame(width: 300, height: 300)
//                        .onTapGesture {
//                            beeMode.toggle()
//                        }
   
                }
                .frame(width: geometry.size.width * 0.8)
                
                
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 420)
            .position(x: geometry.size.width / 2, y: geometry.size.height/2 )
            
        }
        .frame(maxWidth: .infinity, maxHeight: 430)
    }
}
struct HintText: View{
    
    @EnvironmentObject var settings: HiveSettings
    
    var body: some View{
        HStack{
            Image("RightArrow")
                .padding(.horizontal, 25)
            Text(settings.currentMode == .beeMode ? "开始探索" : "开始种植")
                .fontWeight(.medium)
                .foregroundColor(Color(red: 0.27, green: 0.17, blue: 0.13).opacity(0.7))
               
            Image("ARIcon")
        }
        .frame(width: 235, height: 58)
    }
}

struct SlideToBegin: View {
 
    @EnvironmentObject var settings: HiveSettings
    
    @Binding var imageOffsetY: CGFloat
    @Binding var imageOffsetZ: CGFloat
    @Binding var offsetX: CGFloat
    @Binding var navigateToNextScreen: Bool
    
    func calculateImageOffsetZ(from offsetX: CGFloat) -> CGFloat {
        let scaleRange: CGFloat = 1.1 - 1.0
        let sliderRange = 235.0 - 52.0
        return 1.0 + (offsetX / sliderRange) * scaleRange
    }
    
    var body: some View {
        // GeometryReader 用于获取视图的尺寸信息
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 药丸形状的背景
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(settings.currentMode == .beeMode ? Color(red: 1, green: 0.94, blue: 0.65) : Color(red: 0.71, green: 0.93, blue: 0.46).opacity(0.7))
                        .frame(width: 235, height: 58)
                    HintText()
                    //Text("开始探索")
                        .frame(width: 235, height: 58)
                        .mask(
                            HStack {
                                Spacer()
                                Rectangle()
                                    .fill(Color.black)  // 使用黑色来遮罩
                                    .frame(width: 235-offsetX-4)
                            }
                            .frame(height: 58)
                        )
                }
                ZStack{
                    Circle()
                        .foregroundColor(Color.clear)
                        .frame(width: 52, height: 52)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(red: 1, green: 0.88, blue: 0.27),Color(red: 1, green: 0.65, blue: 0.13)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(30)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 2)
                        .opacity(settings.currentMode == .beeMode ? 1 : 0)
                    
                    Circle()
                        .foregroundColor(Color.clear)
                        .frame(width: 52, height: 52)
                        .background(
                            LinearGradient(
                                stops: [
                                Gradient.Stop(color: Color(red: 0.2, green: 0.75, blue: 0.29), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.59, green: 0.88, blue: 0.28), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.95, y: 0.74),
                                endPoint: UnitPoint(x: 0.1, y: 0.23)
                            )
                        )
                        .cornerRadius(30)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 2)
                        .opacity(settings.currentMode == .beeMode ? 0 : 1)
                    
                    
                    Image("BeeIconSlide")
                        .opacity(settings.currentMode == .beeMode ? 1 : 0)
                    Image("FlowerIconSlide")
                        .opacity(settings.currentMode == .beeMode ? 0 : 1)
                       
                }
                .offset(x: offsetX) // 控制滑块不超出药丸条范围
                .gesture(DragGesture()
                    .onChanged({ (value) in
                        let dragAmount = value.translation.width
                        // 更新偏移量，但保持在范围内
                        offsetX = min(235 - 52, max(0, dragAmount))
                        imageOffsetY = -(offsetX / (235 - 52)) * 40
                        imageOffsetZ = calculateImageOffsetZ(from: offsetX)
                    })
                    .onEnded({ (value) in
                        // 如果滑块移动到药丸条的最右端，激发导航
                        if offsetX >= 235 - 52 {
                            navigateToNextScreen = true
                        } else {
                            // 如果未滑动到最右端，图标返回到初始位置
                            withAnimation {
                                offsetX = 4
                                imageOffsetY = 0
                                imageOffsetZ = 1
                            }
                        }
                    })
                )
            }
            //.frame(width: 235, height: 58)
            .frame(width: geometry.size.width, height: 58)
        }
        .frame(height: 58)
    }
}
struct NextView: View {
    var body: some View {
        Text("Welcome to the next screen!")
            .padding()
    }
}






struct Wave: Shape {
    
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
struct HoneyWaveView: View{
    
    @EnvironmentObject var settings: HiveSettings
    @State private var waveOffset: CGFloat = 0.0
    @State private var waveHeight: CGFloat = 100
    
    var body: some View{
        let gradientBee = LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 1, green: 0.88, blue: 0.27).opacity(0.8), location: 0.00),
                Gradient.Stop(color: Color(red: 1, green: 0.66, blue: 0.14).opacity(0.8), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
        let gradientPlant = LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.59, green: 0.88, blue: 0.28), location: 0.00),
                Gradient.Stop(color: Color(red: 0.2, green: 0.75, blue: 0.28), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
       
        ZStack{
            Wave(animatableData: waveOffset)
                .fill(gradientBee)
                .frame(height: waveHeight)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 50)
                .animation(Animation.linear(duration: 16).repeatForever(autoreverses: false), value: waveOffset)
                .onAppear() {
                    self.waveOffset += 1
                }
                .opacity(settings.currentMode == .beeMode ? 1 : 0)
            
            Wave(animatableData: waveOffset)
                .fill(gradientPlant)
                .frame(height: waveHeight)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 50)
                .animation(Animation.linear(duration: 16).repeatForever(autoreverses: false), value: waveOffset)
                .onAppear() {
                    self.waveOffset += 1
                }
                .opacity(settings.currentMode == .beeMode ? 0 : 1)
        }
       
        
    }
}









