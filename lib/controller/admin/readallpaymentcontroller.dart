import 'package:get/get.dart';
import 'package:period_tracker/model/paymentreadingmodel.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/utils/remoteservices.dart';

class ReadAllPaymentController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchAllPayments();
  }

  bool loading = false;
  List<PaymentReadingModel> payments = <PaymentReadingModel>[];
  fetchAllPayments() async {
    loading = true;
    update();
    var response = await RemoteServices.readAllPayments();
    payments = paymentReadingModelFromJson(response);
    loading = false;
    update();
  }
}
