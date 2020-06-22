## RUNNER'S PLACE

## アプリ概要
ランナー同士のコミュニケーションをサポートするWEBアプリケーションです。
日々のランニング結果の記録や共有、練習会などのイベント情報の投稿や参加申請が可能です。
他ユーザのランニング結果を閲覧することで自身のモチベーションを上げるとともに、
イベント参加を通じて、ランナー同士の新たな出会いを実現します。

## コンセプト
世の中にランニング記録の管理ツールはありますが、ランナー同士をマッチングさせるツールはないことに着目し、「場所を問わずランナー同士が気軽に繋がれること」をテーマに開発に着手しました。

## デプロイ先
作成中（AWSを予定）

## 使用技術・バージョン情報
- Ruby 2.6.5
- rails 5.2.3
- PostgresQL
- GoogleMaps Javascript API
- GoogleMaps Geocoding API
- Nginx
- unicorn
- AWS(EC2,S3)
- RSpec
- JavaScript, JQuery
- HTML/CSS
- Bootstrap

## 機能一覧
- ランニング記録の投稿/編集/削除機能
- ランニング記録の一覧表示機能
	- 自ユーザーの記録一覧画面にはカレンダーとフォロー中のユーザの最新記録(4件)を合わせて表示
- ランニング記録の絞り込み検索機能
	（ユーザー名での検索・テキストの部分一致や複数条件、練習日の範囲検索も可能）
- ランニング記録のいいね！機能(Ajax)
- ランニング記録のコメント機能(Ajax)
- イベント情報の投稿/編集/削除機能
	- 登録した場所をgooglemapsAPIを使ってジオコーディングし、googlemaps上にマーカー表示
- イベント情報の一覧表示機能
	-　登録されているすべてのイベントをgooglemaps上に複数マーカー表示
- イベントへのコメント機能(Ajax)
- イベントへの参加申請機能(Ajax)
- ユーザ新規登録/編集/退会機能
	- ユーザプロフィール画面に参加予定のイベント一覧を表示
- ログイン/ゲストログイン機能
- ユーザフォロー機能(Ajax)

## カタログ設計、テーブル定義、ER図、画面遷移図、ワイヤーフレーム
[googleスプレッドシート(リンク)](https://docs.google.com/spreadsheets/d/1g0jrGgkDyIFhDhInIooUPK04J--3VZkqhPxqTsfz1bc/edit?usp=sharing)

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

