# YSColorPicker
YSColorPickerは簡単に使えるカラーピッカーライブラリです。

#Features
- RGB
- RGBA
- HSB
- HSBA
- ColorPicker
- ColorPicker(alpha)
これらのモードから任意で複数選ぶことができます。

#Installation
### CocoaPods

1. Podfileに pod `'YSColorPicker', :git => 'https://github.com/sekies/YSColorPicker.git'` と追加します。
1. pod install します。
1. インポートします。 `import YSColorPicker`

#Usage
1. `YSColorsTabViewControllerDelegate` を実装します。
1. カラーピッカーを使用したいタイミングで`YSColorsTabViewController`インスタンスを生成します。生成時に初期カラーとピッカーのタイプを指定します。

        let tabvc = YSColorsTabViewController(color: btn.backgroundColor!, colorTypes: [
            .YS_COLOR_RGB,
            .YS_COLOR_RGBA,
            .YS_COLOR_HSB,
            .YS_COLOR_HSBA
           	])
        tabvc.view.backgroundColor = .white
        tabvc.ysColorDelegate = self
        present(tabvc, animated: true, completion: nil)
タイプの指定は以下の6種類から可能です。
.YS_COLOR_PICKER,
.YS_COLOR_PICKERA,
.YS_COLOR_RGB,
.YS_COLOR_RGBA,
.YS_COLOR_HSB,
.YS_COLOR_HSBA

1. デリゲートメソッドを実装します。カラーが変更されるたびにこのメソッドが呼び出されます。
    func ysChanged(color: UIColor) {
        btn.backgroundColor = color
    }