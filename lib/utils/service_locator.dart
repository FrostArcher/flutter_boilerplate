final serviceLocator = ServiceLocator();


class ServiceLocator {
  // Singleton instance
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;

  // Private constructor
  ServiceLocator._internal();

  // Storage for registered instances
  final Map<Type, dynamic> _services = {};

  /// Registers a singleton instance
  void registerSingleton<T>(T instance) {
    _services[T] = instance;
  }

  /// Registers a lazy singleton (created on first use)
  void registerLazySingleton<T>(T Function() instanceBuilder) {
    _services[T] = instanceBuilder;
  }

  /// Retrieves an instance
  T get<T>() {
    final instance = _services[T];

    // If it's a function, call it to create the instance
    if (instance is Function) {
      _services[T] = instance();
    }

    return _services[T] as T;
  }

  /// Checks if a service is registered
  bool isRegistered<T>() => _services.containsKey(T);
}