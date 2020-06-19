## アプリ名
RUNNER'S PLACE

## コンセプト
- RUNNER'S PLACEはランナーのためのコミュニケーションサービスです。
- 日々のランニング記録の管理・共有はもちろん、練習会などのイベント情報の投稿機能や参加申請が可能です。
- あなたのランニングライフに寄り添い、新たな仲間との出会いをもたらします。

## デプロイ先
- ※作成中

## バージョン情報、使用技術
- Ruby 2.6.5
- rails 5.2.3
- PostgresQL
- GoogleMaps Javascript API
- GoogleMaps Geocoding API
- Nginx, unicorn
- AWS
- RSpec
- JavaScript, JQuery

## 機能一覧
- ランニング記録の投稿/閲覧機能
- ランニング記録の検索機能
- ランニング記録のいいね！機能
- ランニング記録のコメント機能
- イベント情報の投稿/閲覧機能
	- 登録した場所は緯度・経度を検索し、googlemaps上にマーカーを描画
- イベント情報の検索機能
- イベントへのコメント機能
- イベントへの参加申請機能
- ユーザ登録/ログイン機能
- ゲストログイン機能
- ユーザ情報閲覧機能
- ユーザフォロー機能

## カタログ設計、テーブル定義、ER図、画面遷移図、ワイヤーフレーム
https://docs.google.com/spreadsheets/d/1g0jrGgkDyIFhDhInIooUPK04J--3VZkqhPxqTsfz1bc/edit?usp=sharing

## 使用gem
- simple_calender
- kaminari
- carrierwave
- mini_magick
- fog-aws
- devise
- devise_i18n
- rspec-rails
- capybara
- geocoder

