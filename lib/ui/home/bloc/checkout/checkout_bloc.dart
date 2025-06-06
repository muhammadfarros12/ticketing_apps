import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticketing_apps/model/request/order_item.dart';
import 'package:ticketing_apps/model/response/product_response_model.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(_Initial()) {
    on<_addCheckout>((event, emit) {
      if (state is _Success) {
        final current_State = state as _Success;
        List<OrderItem> products = [...current_State.product];
        final index = products.indexWhere(
          (element) => element.product.id == event.product.id,
        );
        if (index >= 0) {
          products[index].quantity += 1;
        } else {
          products.add(OrderItem(product: event.product, quantity: 1));
        }

        emit(_Loading());
        emit(_Success(products));
      } else {
        emit(_Success([OrderItem(product: event.product, quantity: 1)]));
      }
    });
    on<_RemoveCheckout>((event, emit) {
      if (state is _Success) {
        final currentState = state as _Success;
        List<OrderItem> products = [...currentState.product];
        final index = products.indexWhere(
          (element) => element.product.id == event.product.id,
        );
        if (index >= 0) {
          if (products[index].quantity > 1) {
            products[index].quantity -= 1;
          } else if (products[index].quantity <= 1){
            products[index].quantity = 0;
          }
        } else {
          products.removeAt(index);
        }
        emit(_Loading());
        emit(_Success(products));
      }
    });

    on<_Started>((event, emit) {
      emit(_Loading());
      emit(_Success([]));
    });
  }
}
