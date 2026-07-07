/// Convenience helpers on [List].
extension ListExtension<R> on List<R> {
  /// Maps each element together with its index into a new list.
  List<T> builder<T>(
    T Function(
      R e,
      int index,
    ) toElement,
  ) {
    return List<T>.generate(
      length,
      (index) {
        return toElement(
          elementAt(index),
          index,
        );
      },
    );
  }
}
