# PocketBudget

VIPER clean architecture for a mini budget app example.

## ExtendedFoundations framework

A separate framework is included in the project, which can be reused in other applications, containing new simple classes and common extensions of UIKit & Foundations.

### Main features

#### Load your views easily

[An extension of UIViewController](https://github.com/jtouzy/PocketBudget/blob/master/PocketBudget/ExtendedFoundations/ExtendedFoundations/Extensions/UIViewController%2Bextensions.swift) provides a way to easily create a new `UIViewController`, from a given storyboard, with a single line of code.

```swift
guard let myView: MyViewController = UIViewController.load(from: "MyStoryboard") else { return }
```

In the same way, [an extension of UIView](https://github.com/jtouzy/PocketBudget/blob/master/PocketBudget/ExtendedFoundations/ExtendedFoundations/Extensions/UIView%2Bextensions.swift) provides a static function to load a view associated to a XIB file. The XIB file should have the same name as the `UIView` class.

```swift
guard let myView: MyView = UIView.load() else { return }
```

In addition, `UIView` and `UIViewController` are conforming to a new protocol named `UIIdentifiable`. This allows you to have a static identifier key to identify your class, during cell registering or dequeueing for example.

```swift
// Registering cell type
tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
// Dequeueing a cell
tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
```

#### Improve localization

[UILocalizableLabel](https://github.com/jtouzy/PocketBudget/blob/master/PocketBudget/ExtendedFoundations/ExtendedFoundations/Components/UILocalizableLabel.swift) & [UILocalizableButton](https://github.com/jtouzy/PocketBudget/blob/master/PocketBudget/ExtendedFoundations/ExtendedFoundations/Components/UILocalizableButton.swift) are respectively `UILabel` and `UIButton` subclasses, which provides `@IBInspectable` property called `localizedKey`.

When you define it in a view controller from a storyboard, the `text` of the displayed label will be calculated as an `NSLocalizedString`. This enables you to easily use localized strings from Interface Builder.
