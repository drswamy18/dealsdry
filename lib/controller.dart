import 'package:dealsdry/dioclient.dart';
import 'package:dealsdry/homepagemodel.dart';
import 'package:dealsdry/usermodel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DealsdryController extends GetxController {
  final DioClient _dioClient = DioClient();
  UserDetailes user = UserDetailes();

  set _user(value) {
    user = value;
  }

  get _user => user;

  userlogin({required String phoneNumber}) async {
    try {
      var data = await _dioClient.userlogin(phonenumber: phoneNumber);
      update();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("deviceId", data.toString());
      return user;
    } finally {}
  }

  userloginotp({required String otp, String? userId, String? deviceId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString("userId");
    try {
      var data = await _dioClient.userloginotp(otp: otp, userId: userId);
      update();
      return data;
    } finally {}
  }

  RegisterUser(
      {required String email,
      required String password,
      required String referralCode}) async {
    try {
      var data = await _dioClient.Registeruser(
          email: email, password: password, referralCode: referralCode);
      update();
      return data;
    } finally {}
  }

  List<Homepagemodel> fetchingproducts = [];
  final loader = false.obs;

  fetchproducts() async {
    try {
      loader(false);
      var data = await _dioClient.fetchProducts();
      if (data != null) {
        List<Homepagemodel> temp = [];
        temp.addAll(data);
        fetchingproducts = temp;
      }
      update();
      return fetchingproducts;
    } finally {
      loader(true);
    }
  }
}
