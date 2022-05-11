import 'package:get/get.dart';
import 'package:period_tracker/controller/datasavingcontroller.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/model/uploadsymptomsmodel.dart';
import 'package:period_tracker/utils/remoteservices.dart';

class GenerateReportController extends GetxController {
  List<UploadSymptomsModel> symptoms = [];
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getAllReport();
  }

  getAllReport() async {
    loading = true;
    update();
    DatasavingController dsc = DatasavingController();
    ProfileModel? profile = await dsc.readProfile();
    var response = await RemoteServices.readMyReports(profile!.id.toString());
    symptoms = uploadSymptomsModelFromJson(response);
    loading = false;
    update();
  }
}
