# API

The API is very similar to the SwiftUI Alerts

## Overview

| SwiftUI Alert | Custom Alert |
|:-:|:-:|
| ![Native Alert](SwiftUI) | ![Custom Alert](Custom) |

You can easily add an Image or change the Font used in the alert, or anything else to your imagination.

Something simple with an image and a text field

![Custom Alert](Fancy)

Or more complex layouts

![Custom Alert](Complex)

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

![Inline Alert](CustomConfiguration)

```swift
.configureCustomAlert { configuration in
    // Adapt the default configuration
}
```

You can also display an Alert inline, within a `List` for example

![Inline Alert](InlineAlert)

```swift
InlineAlert {
    // Content
} actions: {
    // Actions
}
```
