import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// Error dari Server/API
class ServerFailure extends Failure {}

// Error dari Local Storage/Cache
class CacheFailure extends Failure {}
