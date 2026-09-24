import 'package:di360_flutter/feature/supplies/model/get_supply_carts.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resolveSupplierIdForGroup returns the selected supplier UUID', () {
    final vm = SuppliesViewModel();

    vm.suppliesCartData = SupplyCartData(
      supplyCarts: [
        SupplyCarts(
          supply: Supply(
            name: 'Product 1',
            dentalSupplier: DentalSupplier(
              id: 'supplier-uuid-1',
              businessName: 'Acme Dental',
            ),
          ),
        ),
        SupplyCarts(
          supply: Supply(
            name: 'Product 2',
            dentalSupplier: DentalSupplier(
              id: 'supplier-uuid-2',
              businessName: 'Acme Dental',
            ),
          ),
        ),
      ],
    );

    expect(vm.resolveSupplierIdForGroup('Acme Dental'), 'supplier-uuid-1');
  });
}
