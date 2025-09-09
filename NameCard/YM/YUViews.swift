//
//  YUViews.swift
//  NameCard
//
//  Created by 張郁眉 on 2025/9/9.
//

import SwiftUI

struct YUViews: View {
    @State var shake = false
    var body: some View {
        
        VStack{
            YMNameCard()
        }
        .offset(x: shake ? -10 : 0) // 左右位移
                    .animation(
                        shake ? Animation.default.repeatCount(5, autoreverses: true).speed(6) : .default,
                        value: shake
                    )
                    .onTapGesture {
                        shake.toggle()
                        }
                    }
    }
        


#Preview {
    YUViews()
}
