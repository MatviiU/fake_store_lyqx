import 'package:fake_store_lyqx/features/home/data/repository/product_repository.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(ProductDetailsInitial());

  final ProductRepository _productRepository;

  Future<void> getProduct(int id) async {
    emit(ProductDetailsLoading());
    try {
      final product = await _productRepository.getProduct(id);
      emit(ProductDetailsLoaded(product: product));
    } catch (e) {
      emit(ProductDetailsError(message: e.toString()));
    }
  }
}
