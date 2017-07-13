
# 本書の目的
本文書では、iOSアプリケーションの作成に必要な項目や理解するべき概念を列挙することを目的としている。  
具体的な解説等についてはApple developerサイト(https://developer.apple.com/)などに詳細かつ正確な情報が記載されているため、そちらを参照頂く。
なお対象者としてはプログラミングにある程度精通していることを前提としている。そのため、コンパイル、クラス等のプログラミングの用語について、断り無く用いている。

# 目次
- Viewの作成
  - Storyboard/xib
  - Constraints
  - 使用頻度が高いUIコンポーネント
    - UIButton
    - tableView
    - segmentControl
    - UIActivityIndicatorView

- iOSにおけるマルチスレッド
  - Grand Centraol Dispatch

- HTTP通信
  - URLSession
  - JSON

- ViewControllerの概要
  - ViewControllerのライフサイクル
  - 画面遷移

- デバイス制御
  - GPS
  - カメラ

## Viewの作成
Webアプリケーション(サイト)では、ViewをHTML/CSS/JS等のプログラミング言語を用いて実装する。  
iOSでは以下の方法でViewを実装する。

- Storyboardを使用した実装
- xibを使用した実装
- Obj-C/Swiftを使用した実装

上記の3つの方法はいずれも排他的な方法ではなく、併用することが可能である。
現在では上記の3つ全てを用いてViewを実装することが多いが、ショー抽選アプリではStoryboardを使用していない。

### Storyboard/xib
iOS SDKでは、Viewをhtmlではなくxmlを用いて実装する。このxmlをGUIで操作するための機能として、Storyboard/xibがXCodeに存在する。
xib(XML Interface Builder)は、画面上に任意のGUIコンポーネントを配置するためのインターフェースを提供する。  
Storyboardでは、xibが持つ機能の他、画面遷移等の複数画面にまたがるイベント処理等を実装することができる。

#### 例題
- Storyboard/xibを使用して、画面上へUIコンポーネントを配置し、シミュレーター/実機上でそれが表示されることを確認する。

### Constraints
iPhone/iPadは2000年台前半に発表されて以来、様々な縦横比の画面を持つシリーズが販売されてきた。(http://qiita.com/tomohisaota/items/f8857d01f328e34fb551)
こうした複数の縦横比に対応する__レスポンシブデザイン__を実現すること必要であると、Apple社の『Human Interface Guideline』で述べられている。
XCodeでは、レスポンシブデザインを実現するための機能としてConstraintsが存在する。

#### 例題
- Storyboard/xibへ配置したUIコンポーネントを、画面のX/Y軸の真ん中へ配置する。
- 複数のUIコンポーネントを縦方向に配置し、各コンポーネント間に12ポイントの空白を設定する。
- 上記の画面が、iPhone5,iPhone6,iPhone7+のいずれにおいても表示が変わらないことを各確認する。

### 使用頻度が高いUIコンポーネント
#### UIButton
iOSアプリに於いて最も使用頻度が高く、かつ実装が簡単なUIコンポーネントである。
ボタンが指に触れた瞬間/ボタンをダブルクリックしたとき/ボタンを押したあとにボタンの近くで指を離したとき/等、様々なイベントをフックにすることができる。

##### 例題
- 押すと、"pushed"という文言を表示するUIButtonを実装する

#### TableView
UIButtonと同様に、ほぼ全てのiOSアプリで使用されているUIコンポーネントである。  
TwitterやFBのタイムライン等、同じ粒度のデータを複数個表示する際に用いられることが多い。

##### 例題
- セル1,セル2,セル3...と表示するTableViewを実装する

#### UIActivityIndicatorView
通信処理等の時間がかかる処理を行なう際に、処理中であることを示すアニメーションを表示するために使用されるUIコンポーネントである。
多くの場合、GCD等を使った並列処理処理内で用いられる。

##### 例題
- ボタンを押すと表示されるUIActivityIndicatorViewを実装する
- 再度ボタンを押した時、上記のUIActivityIndicatorViewが消えるようにする

#### segmentControl
画面の一番下などに配置し、アプリが持つ機能毎に画面を切り替える際に使用されているUIコンポーネントである。

##### 例題
- "Enable/Disable"を持ち、それぞれボタンの有効化/無効化をするsegmentConrollを実装する

## iOSにおけるマルチスレッド
iOSにおけるマルチスレッド(並列処理)には以下の主に2つが存在する。

- NSThread
    - スレッドを立てて、そのスレッドの中で処理を行う。
    - スレッドの管理やキューイングなどの管理はアプリケーションが行う

- Grand Central Dispatch
    - スレッドの管理をOSレベルで実装したもの
    - 処理をブロックと呼ばれる無名関数(ラムダ)で渡すことができる
    - タスクはFIFOのキューで管理される

多くの場合、通信やI/Oなどの時間がかかる処理を別スレッドで行い、メインスレッドはUI描画のために開放する。
詳しい解説は、以下を参照。
- http://dev.classmethod.jp/smartphone/iphone/swift-3-how-to-use-gcd-api-1/

#### 例題
1.  ボタンを押すとUIActivityIndicatorViewが表示される
2.  キューを生成し、sleep処理を行なう
3.  sleep処理が終わった後、メインスレッド上でUIActivityIndicatorViewを消す

## HTTP通信
ほぼ全てのiOSアプリケーションは、何かしらのHTTP通信を行なう機能を有している。
多くの場合は、Web経由でDBのデータを取得するために、サーバー側へWebAPIと呼ばれるインターフェースを実装する。

iOSにおけるHTTP通信処理はURLSessionを使用する。
詳しい解説は、以下を参照
- http://qiita.com/yutailang0119/items/ab400cb7158295a9c171

#### 例題
- 保守しているのSTG環境へ、GET/POSTリクエストを行なう

### JSON

















