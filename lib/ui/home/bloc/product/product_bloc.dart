import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticketing_apps/data/localdatasources/product_local_datasource.dart';
import 'package:ticketing_apps/data/remotedatasources/product_remote_datasource.dart';
import 'package:ticketing_apps/model/response/product_response_model.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  final ProductLocalDatasource productLocalDatasource;
  ProductBloc(this.productRemoteDatasource, this.productLocalDatasource)
    : super(_Initial()) {
    List<Product> product = [];
    on<_GetProducts>((event, emit) {
      emit(_Loading());
      final response = productRemoteDatasource.getProduct();

      response.then((value) {
        value.fold(
          (error) {
            emit(_Error(error));
          },
          (data) {
            emit(_Success(data.data ?? []));
          },
        );
      });
    });
    on<_SyncProducts>((event, emit) async {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(_Error('No internet connection'));
      } else {
        emit(_Loading());
        print('sync data');
        final response = await productRemoteDatasource.getProduct();
        productLocalDatasource.removeAllProduct();
        productLocalDatasource.insertAllProduct(
          response.getOrElse(() => ProductResponseModel(data: [])).data ?? [],
        );
        product = response.getOrElse(() => ProductResponseModel(data: [])).data ?? [];
        print("total data yang ada: ${product.length}");
        emit(_Success(product));
      }
    });

    on <_GetLocalProducts> ((event, emit) async {
      emit(_Loading());
      print('local data');
      final localProducts = await productLocalDatasource.getProduct();
      product = localProducts;
      emit(_Success(product));
    });
  }
}
