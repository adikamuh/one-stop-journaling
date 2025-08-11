import 'package:meta/meta.dart';

@sealed
abstract class StateController<T> {
  StateController();

  @override
  String toString() => 'Resource of '
      'status: $status, '
      'data: $inferredData, '
      'error message: $inferredErrorMessage';

  factory StateController.idle() {
    return Idle();
  }

  factory StateController.loading({T? data}) {
    return Loading(data);
  }

  factory StateController.success(T data) {
    return Success(data);
  }

  factory StateController.failure({
    T? data,
    required String errorMessage,
    int? code,
  }) {
    return Failure(errorMessage, code, data);
  }

  factory StateController.of({
    T? data,
    String? errorMessage,
  }) {
    if (errorMessage != null) {
      return StateController.failure(errorMessage: errorMessage, data: data);
    } else if (data != null) {
      return StateController.success(data);
    } else {
      return StateController.loading(data: data);
    }
  }

  StateController<U> transform<U>({
    required final U Function(T data) transformer,
  }) {
    final resource = this;

    if (resource is Success<T>) {
      return StateController.success(transformer.call(resource.data));
    }
    final data = resource.inferredData;

    if (resource is Failure<T>) {
      return StateController.failure(
        errorMessage: resource.errorMessage,
        data: data == null ? null : transformer.call(data),
      );
    }

    if (resource is Loading<T>) {
      return StateController.loading(
        data: data == null ? null : transformer.call(data),
      );
    }

    return StateController.idle();
  }

  String? get inferredErrorMessage {
    final resource = this;

    if (resource is Failure<T>) {
      return resource.errorMessage;
    }

    return null;
  }

  T? get inferredData {
    final resource = this;

    if (resource is Success<T>) {
      return resource.data;
    } else if (resource is Failure<T>) {
      return resource.data;
    } else if (resource is Loading<T>) {
      return resource.data;
    }

    return null;
  }

  String get status {
    final resource = this;

    if (resource is Success<T>) {
      return StateController.statusSuccess;
    } else if (resource is Failure<T>) {
      return StateController.statusError;
    } else if (resource is Loading<T>) {
      return StateController.statusLoading;
    }

    return StateController.statusIdle;
  }

  bool get isLoading => status == statusLoading;

  bool get isError => status == statusError;

  bool get isSuccess => status == statusSuccess;

  U compose<U>({
    required final U Function(Success<T>) onSuccess,
    final U Function(Failure<T>)? onError,
    final U Function(Loading<T>)? onLoading,
    final U Function()? onIdle,
    required final U orElse,
  }) {
    final resource = this;

    if (resource is Success<T>) {
      return onSuccess(resource);
    } else if (resource is Failure<T>) {
      return onError?.call(resource) ?? orElse;
    } else if (resource is Loading<T>) {
      return onLoading?.call(resource) ?? orElse;
    } else if (resource is Idle<T>) {
      return onIdle?.call() ?? orElse;
    }

    return orElse;
  }

  U? onSuccess<U>(U Function(Success<T> success) successCallback) {
    final resource = this;

    return resource is Success<T> ? successCallback(resource) : null;
  }

  U? onError<U>(U Function(Failure<T> error) errorCallback) {
    final resource = this;

    return resource is Failure<T> ? errorCallback(resource) : null;
  }

  U? onLoading<U>(U Function(Loading<T> loading) loadingCallback) {
    final resource = this;

    return resource is Loading<T> ? loadingCallback(resource) : null;
  }

  static const statusSuccess = "success";
  static const statusError = "error";
  static const statusLoading = "loading";
  static const statusIdle = "idle";
}

class Loading<T> extends StateController<T> {
  Loading(this.data);

  final T? data;
}

class Idle<T> extends StateController<T> {}

class Success<T> extends StateController<T> {
  Success(this.data);

  final T data;
}

class Failure<T> extends StateController<T> {
  Failure(this.errorMessage, this.code, this.data);

  final String errorMessage;
  final int? code;
  final T? data;

  @override
  String toString() => "$code: $errorMessage";
}
