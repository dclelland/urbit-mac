# Defaults [![Build Status](https://travis-ci.org/sindresorhus/Defaults.svg?branch=master)](https://travis-ci.org/sindresorhus/Defaults)

> Swifty and modern [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)

This package is used in production by apps like [Gifski](https://github.com/sindresorhus/Gifski), [Dato](https://sindresorhus.com/dato), [Lungo](https://sindresorhus.com/lungo), [Battery Indicator](https://sindresorhus.com/battery-indicator), and [HEIC Converter](https://sindresorhus.com/heic-converter).


## Highlights

- **Strongly typed:** You declare the type and default value upfront.
- **Codable support:** You can store any [Codable](https://developer.apple.com/documentation/swift/codable) value, like an enum.
- **Debuggable:** The data is stored as JSON-serialized values.
- **Observation:** Observe changes to keys.
- **Lightweight:** It's only ~300 lines of code.


## Compatibility

- macOS 10.12+
- iOS 10+
- tvOS 10+
- watchOS 3+


## Install

#### SwiftPM

```swift
.package(url: "https://github.com/sindresorhus/Defaults", from: "3.0.0")
```

#### Carthage

```
github "sindresorhus/Defaults"
```

#### CocoaPods

```ruby
pod 'Defaults'
```


## Usage

You declare the defaults keys upfront with type and default value.

```swift
import Cocoa
import Defaults

extension Defaults.Keys {
	static let quality = Key<Double>("quality", default: 0.8)
	//            ^            ^         ^                ^
	//           Key          Type   UserDefaults name   Default value
}
```

You can then access it as a subscript on the `Defaults` global:

```swift
Defaults[.quality]
//=> 0.8

Defaults[.quality] = 0.5
//=> 0.5

Defaults[.quality] += 0.1
//=> 0.6

Defaults[.quality] = "🦄"
//=> [Cannot assign value of type 'String' to type 'Double']
```

You can also declare optional keys for when you don't want to declare a default value upfront:

```swift
extension Defaults.Keys {
	static let name = OptionalKey<Double>("name")
}

if let name = Defaults[.name] {
	print(name)
}
```

The default value is then `nil`.

### Enum example

```swift
enum DurationKeys: String, Codable {
	case tenMinutes = "10 Minutes"
	case halfHour = "30 Minutes"
	case oneHour = "1 Hour"
}

extension Defaults.Keys {
	static let defaultDuration = Key<DurationKeys>("defaultDuration", default: .oneHour)
}

Defaults[.defaultDuration].rawValue
//=> "1 Hour"
```

### Use keys directly

You are not required to attach keys to `Defaults.Keys`.

```swift
let isUnicorn = Defaults.Key<Bool>("isUnicorn", default: true)

Defaults[isUnicorn]
//=> true
```

### Observe changes to a key

```swift
extension Defaults.Keys {
	static let isUnicornMode = Key<Bool>("isUnicornMode", default: false)
}

let observer = Defaults.observe(.isUnicornMode) { change in
	// Initial event
	print(change.oldValue)
	//=> false
	print(change.newValue)
	//=> false

	// First actual event
	print(change.oldValue)
	//=> false
	print(change.newValue)
	//=> true
}

Defaults[.isUnicornMode] = true
```

In contrast to the native `UserDefaults` key observation, here you receive a strongly-typed change object.

### Reset keys to their default values

```swift
extension Defaults.Keys {
	static let isUnicornMode = Key<Bool>("isUnicornMode", default: false)
}

Defaults[.isUnicornMode] = true
//=> true

Defaults.reset(.isUnicornMode)

Defaults[.isUnicornMode]
//=> false
```

This works for `OptionalKey` too, which will be reset back to `nil`.

### It's just `UserDefaults` with sugar

This works too:

```swift
extension Defaults.Keys {
	static let isUnicorn = Key<Bool>("isUnicorn", default: true)
}

UserDefaults.standard[.isUnicorn]
//=> true
```

### Shared `UserDefaults`

```swift
let extensionDefaults = UserDefaults(suiteName: "com.unicorn.app")!

extension Defaults.Keys {
	static let isUnicorn = Key<Bool>("isUnicorn", default: true, suite: extensionDefaults)
}

Defaults[.isUnicorn]
//=> true

// Or

extensionDefaults[.isUnicorn]
//=> true
```

### Default values are registered with `UserDefaults`

When you create a `Defaults.Key`, it automatically registers the `default` value with normal `UserDefaults`. This means you can make use of the default value in, for example, bindings in Interface Builder.

```swift
extension Defaults.Keys {
	static let isUnicornMode = Key<Bool>("isUnicornMode", default: true)
}

print(UserDefaults.standard.bool(forKey: isUnicornMode.name))
//=> true
```


## API

### `Defaults`

#### `Defaults.Keys`

Type: `class`

Stores the keys.

#### `Defaults.Key` *(alias `Defaults.Keys.Key`)*

```swift
Defaults.Key<T>(_ key: String, default: T, suite: UserDefaults = .standard)
```

Type: `class`

Create a key with a default value.

The default value is written to the actual `UserDefaults` and can be used elsewhere. For example, with a Interface Builder binding.

#### `Defaults.OptionalKey` *(alias `Defaults.Keys.OptionalKey`)*

```swift
Defaults.OptionalKey<T>(_ key: String, suite: UserDefaults = .standard)
```

Type: `class`

Create a key with an optional value.

#### `Defaults.reset`

```swift
Defaults.reset<T: Codable>(_ keys: Defaults.Key<T>..., suite: UserDefaults = .standard)
Defaults.reset<T: Codable>(_ keys: [Defaults.Key<T>], suite: UserDefaults = .standard)
Defaults.reset<T: Codable>(_ keys: Defaults.OptionalKey<T>..., suite: UserDefaults = .standard)
Defaults.reset<T: Codable>(_ keys: [Defaults.OptionalKey<T>], suite: UserDefaults = .standard)
```

Type: `func`

Reset the given keys back to their default values.

#### `Defaults.observe`

```swift
Defaults.observe<T: Codable>(
	_ key: Defaults.Key<T>,
	options: NSKeyValueObservingOptions = [.initial, .old, .new],
	handler: @escaping (KeyChange<T>) -> Void
) -> DefaultsObservation
```

```swift
Defaults.observe<T: Codable>(
	_ key: Defaults.OptionalKey<T>,
	options: NSKeyValueObservingOptions = [.initial, .old, .new],
	handler: @escaping (OptionalKeyChange<T>) -> Void
) -> DefaultsObservation
```

Type: `func`

Observe changes to a key or an optional key.

By default, it will also trigger an initial event on creation. This can be useful for setting default values on controls. You can override this behavior with the `options` argument.

#### `Defaults.removeAll`

```swift
Defaults.removeAll(suite: UserDefaults = .standard)
```

Type: `func`

Remove all entries from the `UserDefaults` suite.


## FAQ

### How is this different from [`SwiftyUserDefaults`](https://github.com/radex/SwiftyUserDefaults)?

It's inspired by that package and other solutions. The main difference is that this module doesn't hardcode the default values and comes with Codable support.


## Related

- [Preferences](https://github.com/sindresorhus/Preferences) - Add a preferences window to your macOS app in minutes
- [LaunchAtLogin](https://github.com/sindresorhus/LaunchAtLogin) - Add "Launch at Login" functionality to your macOS app
- [DockProgress](https://github.com/sindresorhus/DockProgress) - Show progress in your app's Dock icon
- [Gifski](https://github.com/sindresorhus/Gifski) - Convert videos to high-quality GIFs on your Mac
- [More…](https://github.com/search?q=user%3Asindresorhus+language%3Aswift)
