part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class ListenConnection extends NetworkEvent {}

class ConnectionChanged extends NetworkEvent {
  final NetworkState connection;
  const ConnectionChanged(this.connection);
}
