import 'package:flutter_ecommerce/models/flash_sale.dart';
import 'package:flutter_ecommerce/services/flashsale_service.dart';

class FlashSaleRepository {
  final FlashSaleService _flashSaleService;

  FlashSaleRepository({required FlashSaleService flashSaleService})
      : _flashSaleService = flashSaleService;

  Future<void> addFlashSale(FlashSale flashSale) async {
    await _flashSaleService.addFlashSaleToFirebase(flashSale);
  }

  Future<List<FlashSale>> getAllFlashSales() async {
    return _flashSaleService.getAllFlashSales();
  }
}
