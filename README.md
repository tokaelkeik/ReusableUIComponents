# SwiftUI Navigation Menu Component

A versatile and customizable navigation menu component for SwiftUI applications. This component supports various styles and configurations, making it suitable for a wide range of UI designs.

![ezgif-3-f4bd42de18](https://github.com/tokaelkeik/ReusableUIComponents/assets/77276105/2fcda0dc-f07e-419f-b823-95fe3650c3af)

## Features

- **Customizable Menu Items**: Define menu items with text and optional selected/unselected images.
- **Scrollable and Non-Scrollable Menus**: Choose between scrollable and fixed menus.
- **Different Layout Styles**: Supports underline and chip styles.
- **Smooth Transitions**: Animated transitions for item selection changes.
- **Environment-Driven Configuration**: Utilize environment values for flexible menu configuration.

**Table of Contents**
- [Installation](#installation)
- [Usage](#usage)
- [Customization](#customization)
- [Components](#components)
- [Examples](#examples)
- [License](#license)


## Installation

To use this navigation menu component, you can directly include the provided Swift files in your project or integrate it via Swift Package Manager.

### Swift Package Manager

1. In Xcode, go to `File > Add Packages`.
2. Enter the URL of this repository.
3. Follow the prompts to add the package to your project.

## Usage

All you need to use the Navigation Menu is to conform to `MenuItemProtocol` in your object, pass a state object `selectedIndex`, specify if it is scrollable or not, and implement the action handler callback. Here is an example:
### Example

```swift
// MARK: - MenuItem
struct MenuItem: MenuItemProtocol {
    var text: String
    var selectedImage: Image?
    var unselectedImage: Image?
}

struct ChipMenuExample: View {
    @State var selectedIndex: Int = 0
    var menuItems: [MenuItem] = [
        MenuItem(text: "First Item"),
        MenuItem(text: "second Item"),
        MenuItem(text: "Third Item"),
        MenuItem(text: "Forth")
    ]

    var body: some View {
        NavigationMenu(
            selectedIndex: $selectedIndex,
            menuItems: menuItems,
            isScrollable: true,
            actionHandler: { selectedIndex in
                print("Selected item at index: \(selectedIndex)")
            }
        )
        .menuConfiguration(ChipMenuConfiguration())
    }
}
```

## Customization

The navigation menu is highly customizable. You just need to provide the `.menuConfiguration` modifier and you can choose from either `ChipMenuConfiguration` or `UnderlineMenuConfiguration`. Each of them has several attributes you can change. Here they are with their default values:

### UnderlineMenuConfiguration

| Attribute                | Default Value                               |
|--------------------------|---------------------------------------------|
| `viewHeight`             | `CGFloat = 48`                              |
| `itemPadding`            | `CGFloat = 12`                              |
| `menuBackgroundColor`    | `Color = .clear`                            |
| `selectedTextColor`      | `Color = .black`                            |
| `unselectedTextColor`    | `Color = .blue`                             |
| `selectedFont`           | `Font = .system(size: 16, weight: .bold)`   |
| `unselectedFont`         | `Font = .system(size: 16, weight: .regular)`|
| `underlineColor`         | `Color = .black`                            |
| `underlineTopPadding`    | `CGFloat = 20`                              |
| `underlineHeight`        | `CGFloat = 3`                               |
| `imageWidth`             | `CGFloat = 30`                              |
| `imagePadding`           | `CGFloat = 10`                              |
| `margin`                 | `CGFloat = 5`                               |
| `unSelectedImageOpacity` | `CGFloat = 0.5`                             |
| `imagePosition`          | `ImagePosition = .above`                    |
| `takeEntireAvailableSpace` | `Bool = false`                           |

By setting `takeEntireAvailableSpace` to `true`, you can make your menu stretch to take the whole available space. The default value is `false`.

### ChipMenuConfiguration

| Attribute                       | Default Value                               |
|---------------------------------|---------------------------------------------|
| `viewHeight`                    | `CGFloat = 48`                              |
| `innerViewHeight`               | `CGFloat = 40`                              |
| `itemPadding`                   | `CGFloat = 12`                              |
| `menuBackgroundColor`           | `Color = .clear`                            |
| `selectedItemBackgroundColor`   | `Color = .clear`                            |
| `unselectedItemBackgroundColor` | `Color = .clear`                            |
| `selectedTextColor`             | `Color = .black`                            |
| `unselectedTextColor`           | `Color = .blue`                             |
| `borderWidth`                   | `CGFloat = 1`                               |
| `cornerRadius`                  | `CGFloat = 5`                               |
| `selectedBorderColor`           | `Color = .clear`                            |
| `unselectedBorderColor`         | `Color = .clear`                            |
| `isMaxWidth`                    | `Bool = false`                              |
| `selectedFont`                  | `Font = .system(size: 16, weight: .bold)`   |
| `unselectedFont`                | `Font = .system(size: 16, weight: .regular)`|
| `imageWidth`                    | `CGFloat = 30`                              |
| `imagePadding`                  | `CGFloat = 10` (added to bottom if position is `.above` and to trailing if `.inline`) |
| `unSelectedImageOpacity`        | `CGFloat = 0.5`                             |
| `imagePosition`                 | `ImagePosition = .inline`                   |
| `margin`                        | `CGFloat = 5`                               |
| `takeEntireAvailableSpace`      | `Bool = false`                              |

By setting `takeEntireAvailableSpace` to `true`, you can make your menu stretch to take the whole available space. The default value is `false`.

## Examples

Checkout the demo app in the project.

