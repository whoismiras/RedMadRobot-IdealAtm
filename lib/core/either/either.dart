/// Signature of callbacks that have no arguments and return right or left value.
typedef Callback<T> = void Function(T value);

/// Represents a value of one of two possible types (a disjoint union).
/// Instances of [Either] are either an instance of [Left] or [Right].
/// FP Convention dictates that:
///   [Left] is used for "failure".
///   [Right] is used for "success".
/// ``` dart
/// Future<Either<MyError, MyModel>> _exampleFunction() {
///   _apiCall().then<Either<MyError, MyModel>>(
///     (callResult) => Right<MyError, MyModel>(callResult),
///   ).catchError(
///     (error, _) => Left<MyError, MyModel>(error)
///   )
/// }
///
/// _exampleFunction()..either((error) {...}, (success) {...});
/// ```
/// If you want do some action without return some value from Either, preffer either method on instance:
/// ``` dart
/// someEither.either(
///   (error) => doSomethingWithError(error),
///   (data) => doSomethingWithData(data),
/// );
/// ```
///
/// If you want to return some value from Either, preffer fold method on instance:
/// ``` dart
/// final Either<CertainError, CertainData> result = either.fold(
///   (error) => doSomethingWithError(error),
///   (data) => doSomethingWithData(data),
/// );
/// ```
///
/// When we want to repack Either to another Generic types, use map method on instance:
/// ``` dart
/// final error = Error();
/// final Either<SomeError, SomeData> someEither = Left(error);
///
/// final Either<AnotherError, AnotherData> mappedEither = someEither
///   .map<AnotherError, AnotherData>(
///     (error) => transformError(error),
///     (data) => transformData(data),
///   );
/// ```
abstract class Either<L, R> {
  Either() {
    if (!isLeft && !isRight) {
      throw Exception('The either should be heir Left or Right.');
    }
  }

  /// Represents the left side of [Either] class which by convention is a "Failure".
  bool get isLeft => this is Left<L, R>;

  /// Represents the right side of [Either] class which by convention is a "Success"
  bool get isRight => this is Right<L, R>;

  L get left {
    if (this is Left<L, R>) {
      return (this as Left<L, R>).value;
    } else {
      throw Exception('Illegal use. You should check isLeft() before calling ');
    }
  }

  R get right {
    if (this is Right<L, R>) {
      return (this as Right<L, R>).value;
    } else {
      throw Exception('Illegal use. You should check isRight() before calling');
    }
  }

  void either(Callback<L> fnL, Callback<R> fnR) {
    if (isLeft) {
      final Left<L, R> left = this as Left<L, R>;
      fnL(left.value);
    }

    if (isRight) {
      final Right<L, R> right = this as Right<L, R>;
      fnR(right.value);
    }
  }

  Either<L, R> fold(
    Either<L, R> Function(L value) fnL,
    Either<L, R> Function(R value) fnR,
  ) {
    if (isLeft) {
      final Left<L, R> left = this as Left<L, R>;
      return fnL(left.value);
    } else {
      final Right<L, R> right = this as Right<L, R>;
      return fnR(right.value);
    }
  }

  Either<LL, RR> map<LL, RR>(
    Either<LL, RR> Function(L value) fnL,
    Either<LL, RR> Function(R value) fnR,
  ) {
    if (isLeft) {
      final Left<L, R> left = this as Left<L, R>;
      return fnL(left.value);
    } else {
      final Right<L, R> right = this as Right<L, R>;
      return fnR(right.value);
    }
  }
}

class Left<L, R> extends Either<L, R> {
  final L value;

  Left(this.value);
}

class Right<L, R> extends Either<L, R> {
  final R value;

  Right(this.value);
}
