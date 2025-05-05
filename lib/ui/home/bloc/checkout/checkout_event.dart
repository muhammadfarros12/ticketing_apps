part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  const factory CheckoutEvent.addCheckout(Product product) = _addCheckout;
  const factory CheckoutEvent.removeCheckout(Product product) = _RemoveCheckout;
}