# SwiftUI Navigation Menu Component

A versatile and customizable navigation menu component for SwiftUI applications. This component supports various styles and configurations, making it suitable for a wide range of UI designs.

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
    var imageSelected: Image?
    var imageUnselected: Image?

    var selectedImage: Image? {
        return imageSelected
    }
    
    var unselectedImage: Image? {
        return imageUnselected
    }
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

Information on how to customize the navigation menu, including configuration options and styles.

## Components

Descriptions of the various components that make up the navigation menu, such as `MenuItem`, `NavigationMenu`, `MenuView`, etc.

## Examples

Code examples demonstrating how to use and customize the navigation menu.

## License

Details about the licensing of the customizable navigation menu component.
