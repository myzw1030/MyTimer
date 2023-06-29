//ContentView.swift

import SwiftUI

struct ContentView: View {
    // タイマーの変数を作成
    @State var timerHandler : Timer?
    // カウント（経過時間）の変数を作成
    @State var count = 0
    // 永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 10
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundTimer")
                    .resizable()
                    .ignoresSafeArea()
                // アスペクト比（縦横比）を維持して短辺基準に収まるようにする
                    .scaledToFill()
                VStack(spacing: 30.0) {
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)
                    HStack {
                        Button {
                            startTimer()
                        } label: {
                            Text("スタート")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("startColor"))
                                .clipShape(Circle())
                        }
                        
                        Button {
                            // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                // もしタイマーが、実行中だったら停止
                                if unwrapedTimerHandler.isValid == true {
                                    // タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                        } label: {
                            Text("ストップ")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("stopColor"))
                                .clipShape(Circle())
                        }
                    }
                }
            }
            // 画面が表示される時に実行される
            .onAppear {
                // カウント（経過時間）の変数を初期化
                count = 0
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
    
    // 1秒毎に実行されてカウントダウンする
    func countDownTimer() {
        // count(経過時間)に+1していく
        count += 1
        
        // 残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            // タイマー停止
            timerHandler?.invalidate()
        }
    }
    
    // タイマーをカウントダウン開始する関数
    func startTimer() {
        // timerHandlerをアンラップしてunwrappedTimerHandlerに代入
        if let unwrapedTimerHandler = timerHandler {
            // もしタイマーが、実行中だったらスタートしない
            if unwrapedTimerHandler.isValid == true {
                // 何も処理しない
                return
            }
        }
        
        // 残り時間が0以下のとき、count(経過時間)を0に初期化する
        if timerValue - count <= 0 {
            // count(経過時間)を0に初期化する
            count = 0
        }
        
        // タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // タイマー実行時に呼び出される
            // 1秒毎に実行されてカウントダウンする関数を実行する
            countDownTimer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
