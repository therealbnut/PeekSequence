Defines a new sequence type `PeekSequence`, that can peek at its first value.

Also defines a top level function `nonEmptySequence()` that returns `AnySequence` if a sequence has values, `nil` otherwise.

```swift
Example:
let values: [Int] = [1,2,3,4]
if let sequence = nonEmptySequence(values) {
   for element in sequence {
       print("element: \(element)")
   }
}
else {
   print("empty!")
}
```
