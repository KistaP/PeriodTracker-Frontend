import 'package:get/get.dart';
import 'package:period_tracker/model/profilemodel.dart';
import 'package:period_tracker/utils/remoteservices.dart';

class ReadAllProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchAllProfiles();
  }

// reading profiles
  bool loading = false;
  List<ProfileModel> profiles = <ProfileModel>[];
  fetchAllProfiles() async {
    loading = true;
    update();
    var response = await RemoteServices.readAllProfiles();
    profiles = profilesModelFromJson(response);
    loading = false;
    update();
  }
}
