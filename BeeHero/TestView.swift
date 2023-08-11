//
//  TestView.swift
//  BeeHero
//
//  Created by 洪铭锟 on 2023/8/9.
//

import SwiftUI

struct TestView: View {
    @State var RecColor: Color = Color.clear
    var body: some View {
        Rectangle()
            .fill(RecColor)
            //.border(Color.red) // 临时添加红色边框以查看视图位置和大小
            .frame(width: 300, height: 300)
            .onTapGesture {
                RecColor = Color.red
            }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
