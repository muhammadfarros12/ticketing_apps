import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticketing_apps/data/localdatasources/auth_local_datasource.dart';
import 'package:ticketing_apps/model/request/order_item.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(_Success([], 0, 0, 0, '', 0, '')) {
    on<_AddPaymentMethod>((event, emit) async {
      emit(_Loading());
      final userData = await AuthLocalDatasource().getAuthData();
      emit(
        _Success(
          event.orders,
          event.orders.fold(
            0,
            (previousValue, element) => previousValue + element.quantity,
          ),
          event.orders.fold(
            0,
            (previousValue, element) => previousValue + element.product.price!,
          ),
          0,
          event.paymentMethod,
          userData.user!.id!,
          userData.user!.name!,
        ),
      );
    });
    on<_AddNominalPayment>((event, emit) async {
      var currentState = state as _Success;
      emit(_Loading());
      emit(
        _Success(
          currentState.orders,
          currentState.totalQuantity,
          currentState.totalPrice,
          currentState.nominalPayment,
          currentState.paymentMethod,
          currentState.cashierId,
          currentState.cashierName,
        ),
      );
    });

    on<_Started>((event, emit)async{
      emit(_Loading());
      emit(_Success([], 0, 0, 0, '', 0, ''));
    });
  }
}
