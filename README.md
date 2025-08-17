
<div align="right">
  <details>
    <summary >🌐 Language</summary>
    <div>
      <div align="center">
        <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=en">English</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=zh-CN">简体中文</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=zh-TW">繁體中文</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=ja">日本語</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=ko">한국어</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=hi">हिन्दी</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=th">ไทย</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=fr">Français</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=de">Deutsch</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=es">Español</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=it">Italiano</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=ru">Русский</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=pt">Português</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=nl">Nederlands</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=pl">Polski</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=ar">العربية</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=fa">فارسی</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=tr">Türkçe</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=vi">Tiếng Việt</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=id">Bahasa Indonesia</a>
        | <a href="https://openaitx.github.io/view.html?user=divadretlaw&project=CustomAlert&lang=as">অসমীয়া</
      </div>
    </div>
  </details>
</div>

# CustomAlert

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdivadretlaw%2FCustomAlert%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/divadretlaw/CustomAlert)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdivadretlaw%2FCustomAlert%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/divadretlaw/CustomAlert)

## Why

In iOS Alerts cannot contain Images or anything other than Text. This allows you to easily customize the message part with any custom view.

While the alert is completely rebuilt in SwiftUI, it has been designed to look and behave exactly like a native alert. The alert uses it's own window to be displayed and utilizes accessibility scaling but with the advantage of a custom view.

If the content is too large because the text is too long or the text doesn't fit because of accessibility scaling the content will scroll just like in a SwiftUI Alert.

## Usage

| SwiftUI Alert | Custom Alert |
|:-:|:-:|
| ![Native Alert](Sources/CustomAlert/Documentation.docc/Resources/SwiftUI.png) | ![Custom Alert](Sources/CustomAlert/Documentation.docc/Resources/Custom.png) |

You can easily add an Image or change the Font used in the alert, or anything else to your imagination.

Something simple with an image and a text field

<img src="Sources/CustomAlert/Documentation.docc/Resources/Fancy.png" width="300">

Or more complex layouts

<img src="Sources/CustomAlert/Documentation.docc/Resources/Complex.png" width="300">

The API is very similar to the SwiftUI Alerts

```swift
.customAlert("Some Fancy Alert", isPresented: $showAlert) {
    Text("I'm a custom Message")
        .font(.custom("Noteworthy", size: 24))
    Image(systemName: "swift")
        .resizable()
        .scaledToFit()
        .frame(maxHeight: 100)
        .foregroundColor(.blue)
} actions: {
    Button {
        // some Action
    } label: {
        Label("Swift", systemImage: "swift")
    }
    
    Button(role: .cancel) {
        // some Action
    } label: {
        Text("Cancel")
    }
}
```

You can create Side by Side Buttons using `MultiButton`

```swift
.customAlert("Alert with Side by Side Buttons", isPresented: $showAlert) {
    Text("Choose left or right")
} actions: {
    MultiButton {
        Button {
            // some Action
        } label: {
            Text("Left")
        }

        Button {
            // some Action
        } label: {
            Text("Right")
        }
    }
}
```

The alert is customizable via the `Environment`

<img src="Sources/CustomAlert/Documentation.docc/Resources/CustomConfiguration.png" width="300">

```swift
.configureCustomAlert { configuration in
    // Adapt the default configuration
}
```

You can also display an Alert inline, within a `List` for example

<img src="Sources/CustomAlert/Documentation.docc/Resources/InlineAlert.png" width="300">

```swift
CustomAlertRow {
    // Content
} actions: {
    // Actions
}
```

## Install

### SwiftPM

```
https://github.com/divadretlaw/CustomAlert.git
```

## License

See [LICENSE](LICENSE)
