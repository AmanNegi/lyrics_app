import 'dart:async';

import 'package:bloc/bloc.dart';
import '../helper/data_connection_helper.dart';
import 'package:equatable/equatable.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  late StreamSubscription subscription;

  NetworkBloc() : super(NetworkInitial()) {
    on<ConnectionChanged>((event, emit) {
      //* Simply emit the event connection
      emit(event.connection);
    });

    on<ListenConnection>((event, emit) {
      //* Add Network Connection Listener
      subscription = DataConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status == DataConnectionStatus.disconnected
            ? NetworkFailure()
            : NetworkSuccess()));
      });
    });
  }

  @override
  Future<void> close() {
    //* Dispose off the StreamSubscription
    subscription.cancel();
    return super.close();
  }
}
