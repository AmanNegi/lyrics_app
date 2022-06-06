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
      emit(event.connection);
    });

    on<ListenConnection>((event, emit) {
      print("Listening to events now ");
      subscription = DataConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status == DataConnectionStatus.disconnected
            ? NetworkFailure()
            : NetworkSuccess()));
      });
    });
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
