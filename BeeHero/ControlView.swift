//
//  AllView.swift
//  BeeHero
//
//  Created by 洪铭锟 on 2023/8/9.
//

import SwiftUI

class HiveSettings: ObservableObject {
    @Published var currentMode: HiveMode = .beeMode
    @Published var showHive: Bool = false
    @Published var highlightOffset: CGFloat? = nil
}

enum HiveMode {
    case beeMode
    case plantMode
}

struct ControlView: View {
   // @State var showHive: Bool = false
    @EnvironmentObject var settings: HiveSettings
    
    var body: some View {
        
        ZStack{
            MainView()//.environmentObject(HiveSettings())
                .opacity(settings.showHive ? 0 : 1)
                .animation(.easeOut(duration: 0.5), value: settings.showHive)
                    
            HiveView()//.environmentObject(HiveSettings())
                .opacity(settings.showHive ? 1 : 0)
                .animation(.easeOut(duration: 0.5), value: settings.showHive)
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView().environmentObject(HiveSettings())
    }
}
