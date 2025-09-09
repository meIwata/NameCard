//
//  YMNameCard.swift
//  NameCard
//
//  Created by 張郁眉 on 2025/9/9.
//

import SwiftUI

struct YMNameCard: View {
    var body: some View {
        ZStack {
                    Color(.systemGray6)
                        .ignoresSafeArea()

                    // 名片
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.brown.opacity(0.15)) // 卡片底色
                        .frame(width: 300, height: 180)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color.brown.opacity(0.15), lineWidth: 2)
                        )
                        .shadow(color: .gray.opacity(0.3), radius: 6, x: 4, y: 4)
                        .overlay(
                            VStack(alignment: .leading, spacing: 12) {
                                // 姓名
                                Text("張郁眉")
                                    .font(.title2)
                                    .foregroundColor(.brown)

                                // 聯絡方式
                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.brown)
                                    Text("0936-568086")
                                        .foregroundColor(.primary)
                                        .font(.subheadline)
                                }

                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(.brown)
                                    Text("D1397251@o365.fcu.edu.tw")
                                        .foregroundColor(.primary)
                                        .font(.subheadline)
                                }
                                HStack {
                                    Image(systemName: "pencil.line")
                                        .foregroundColor(.brown)
                                    Text("我拒絕加班")
                                        .foregroundColor(.primary)
                                        .font(.caption2)
                                }

                                Spacer()
                            }
                            .padding()
                        )
                }
    }
}

#Preview {
    YMNameCard()
}
