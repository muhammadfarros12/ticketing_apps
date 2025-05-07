part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = _Initial;
  const factory OrderState.loading() = _Loading;
  const factory OrderState.success(
    List<OrderItem> orders,
    int totalQuantity,
    int totalPrice,
    int nominalPayment,
    String paymentMethod,
    int cashierId,
    String cashierName
  ) = _Success;
  const factory OrderState.Error(String message) = _Error;
}
