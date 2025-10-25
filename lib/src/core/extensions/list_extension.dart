extension ListExtension<R> on List<R> {
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
