//ContentView.swift

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundTimer")
                    .resizable()
                    .ignoresSafeArea()
                // アスペクト比（縦横比）を維持して短辺基準に収まるようにする
                    .scaledToFill()
                VStack(spacing: 30.0) {
                    Text("残り10秒")
                        .font(.largeTitle)
                }
            }
            // ナビゲーションにボタンを追加
            .toolbar {
                // ナビゲーションバーの右にボタンを追加
                ToolbarItem(placement: .navigationBarTrailing) {
                    // ナビゲーション遷移
                    NavigationLink {
                        SettingView()
                    } label: {
                        Text("秒数設定")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
