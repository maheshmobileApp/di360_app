import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/shipping_address/view_model/shipping_address_view_model.dart';
import 'package:di360_flutter/feature/shipping_address/widgets/shipping_address_card.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ShippingAddressView extends StatefulWidget {
  const ShippingAddressView({super.key});

  @override
  State<ShippingAddressView> createState() => _ShippingAddressViewState();
}

class _ShippingAddressViewState extends State<ShippingAddressView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ShippingAddressViewModel>().getShippingAddressesProfessional(
            context,
            isLoadMore: true,
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ShippingAddressViewModel>(context);
    final supVM = context.watch<SuppliesViewModel>();
    final addresses =
        vm.shippingAddressesProfessionalData?.dentalProfessionalAddresses ?? [];

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            leading: IconButton(
                onPressed: () {
                  navigationService.goBack();
                },
                icon: Icon(Icons.arrow_back_ios)),
            title: Text(
              "Shipping Address",
              style: TextStyles.bold3(),
            )),
        body: addresses.isEmpty
            ? Center(child: Text("No Shipping Addresses"))
            : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: addresses.length + (vm.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == addresses.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final item = addresses[index];

                  return ShippingAddressCard(
                    address: item,
                    onMenuSelected: (action) async {
                      switch (action) {
                        case 'delete':
                          showAlertMessage(context,
                              "Are you really want to delete this shipping address?",
                              no: "No", yes: "Yes", onBack: () async {
                            await vm.deleteShippingAddress(
                                context, item.id ?? "");
                          });

                          break;
                        case 'edit':
                          vm.fillController(item);
                          vm.setEditId(item.id ?? "");
                          vm.setEditMode(true);
                          await navigationService
                              .navigateTo(RouteList.addShippingAddressView);

                          break;
                      }
                    },
                  );
                }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            vm.clearControllers();
            await navigationService
                .navigateTo(RouteList.addShippingAddressView);
          },
          child: SvgPicture.asset(ImageConst.addFeed),
        ));
  }
}
