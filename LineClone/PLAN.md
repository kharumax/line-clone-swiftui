#  <#Title#>

次やること
7. バグの修正＆実機確認　
　→ログアウト時のnil compile error
　→HomeViewとProfileViewからTalkRoomViewまで飛ぶ
　→UIのFeedBackなど

実装メモ
UIの作成
→Room一覧・トークルーム（テキスト＋メッセージ）



手順メモ
1. 検索画面を進める
　→ユーザーの一覧表示・検索ができるようにする
2. プロファイル画面
　→自分と他の人のプロフィール画面を表示する
3. 友達追加の機能を追加
　→この時点で既にチャットルームを作る
4. ホーム画面から友達一覧を表示
　→ユーザーをタップして、プロフィールかチャットのどちらかに移行する
5. タイムラインが投稿できるようにする
　→UI作成
　→コメントのUIも作成
　→ViewModelでいいね・コメントできるようにする
　→コメント投稿はモーダルで出来る様にする
6. チャット機能できるようにする
　→チャットルーム作成する

　

あとでやるやつメモ
①通信中にIndicatorを表示するようにする
　→UserがDBにデータを送信する際
　　・ログイン、会員登録、タイムライン投稿、プロフィール編集
　　　検索画面？、友達追加
　→Indicator用のViewを作成する（表示有無を決めるBinding変数を一つ持たせる）
②エラーメッセージを表示できるようにする
　→②と同じ用途で利用
　→Alertで表示する
　→それ用のViewを作成する（メッセージと表示有無）
