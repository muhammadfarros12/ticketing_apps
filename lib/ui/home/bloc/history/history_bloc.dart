import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ticketing_apps/data/localdatasources/product_local_datasource.dart';
import 'package:ticketing_apps/model/request/order_model.dart';

part 'history_bloc.freezed.dart';
part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  ProductLocalDatasource productLocalDatasource;
  HistoryBloc(
    this.productLocalDatasource,
  ) : super(_Initial()) {
    on<HistoryEvent>((event, emit) async {
      emit(_Loading());
      final histories = await productLocalDatasource.getAllOrder();
      print('program cek history');
      emit(_Success(histories));
    });
  }
}
