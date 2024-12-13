// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Model/CalenderEvents.dart';
import 'package:gftr/Model/DeletePre_Events.dart';
import 'package:gftr/Model/Delete_frd.dart';
import 'package:gftr/Model/GetContactList.dart';
import 'package:gftr/Model/MsgNotifications.dart';
import 'package:gftr/Model/Mutulfrd.dart';
import 'package:gftr/Model/RemoveEvents.dart';
import 'package:gftr/Model/addfolder.dart';
import 'package:gftr/Model/addform.dart';
import 'package:gftr/Model/buildgroup.dart';
import 'package:gftr/Model/contactGftr.dart';
import 'package:gftr/Model/contactverfy.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/folderSetting.dart';
import 'package:gftr/Model/folderview.dart';
import 'package:gftr/Model/forgotPassword.dart';
import 'package:gftr/Model/get_calender_events.dart';
import 'package:gftr/Model/get_sll_users.dart';
import 'package:gftr/Model/getgifting.dart';
import 'package:gftr/Model/gftrStories.dart';
import 'package:gftr/Model/groupreplynotification.dart';
import 'package:gftr/Model/inviteemail.dart';
import 'package:gftr/Model/markgift.dart';
import 'package:gftr/Model/mobile_auth.dart';
import 'package:gftr/Model/newPassword.dart';
import 'package:gftr/Model/no_Group.dart';
import 'package:gftr/Model/notification.dart';
import 'package:gftr/Model/prerimend.dart';
import 'package:gftr/Model/renameFolder.dart';
import 'package:gftr/Model/resend.dart';
import 'package:gftr/Model/setting.dart';
import 'package:gftr/Model/signIn.dart';
import 'package:gftr/Model/signUp.dart';
import 'package:gftr/Model/updateProfile.dart';
import 'package:gftr/Model/updateinvite.dart';
import 'package:gftr/Model/verfyforgotOtp.dart';
import 'package:gftr/Model/verifyOtp.dart';
import 'package:gftr/Model/viewdelete.dart';
import 'package:gftr/Model/viewgift.dart';
import 'package:gftr/Model/viewsetting.dart';
import '../Model/GooglelLogin.dart';
import '../Model/all_gift.dart';
import '../Model/groups.dart';

class DioClient {
  final Dio _dio = Dio();
  Future<Encryption?> encryptData(Map<String, dynamic> body) async {
    try {
      Response userData = await _dio.post(ApiConstants.encodeData, data: body);
      return Encryption.fromJson(userData.data);
    } catch (e) {
      print("1 ${e.toString()}");
      return null;
    }
  }

  Future<Encryption?> encryptimgData(Map<String, dynamic> body) async {
    try {
      Response userData = await _dio.post(ApiConstants.encodeData, data: body);
      return Encryption.fromJson(userData.data);
    } catch (e) {
      print("1 ${e.toString()}");
      return null;
    }
  }

  Future<Decryption?> decryptData(String apiUrl, String dataString) async {
    Map<String, dynamic> body = {
      "data": dataString,
    };
    try {
      Response userData = await _dio.post(apiUrl,
          data: body,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': ' $authorization',
          }));
      print('User Info2: ${userData.data}');
      return Decryption.fromJson(userData.data);
    } catch (e) {
      print("2 ${e.toString()}");
      return null;
    }
  }

  Future<Decryption?> decryptDataGetMethod(String apiUrl) async {
    try {
      Response userData = await _dio.get(apiUrl,
          options: Options(headers: {
            'Authorization': ' $authorization',
          }));
      print('User Info2: ${userData.data}');
      print('Get token: ${authorization}');
      return Decryption.fromJson(userData.data);
    } catch (e) {
      print("2 ${e.toString()}");
      print('Get token error : ${authorization}');
      return null;
    }
  }

  Future<Decryption?> decryptDataDeleteMethod(String apiUrl) async {
    try {
      Response userData = await _dio.delete(apiUrl,
          options: Options(headers: {
            'Authorization': ' $authorization',
          }));
      print('User Info2: ${userData.data}');
      return Decryption.fromJson(userData.data);
    } catch (e) {
      print("2 ${e.toString()}");
      log("id delete: $apiUrl");
      return null;
    }
  }

  Future<SignUp?> signUp(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return SignUp.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<FolderSetting?> folderSetting(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return FolderSetting.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<SignIn?> signIn(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(
        ApiConstants.decryptData,
        data: body,
      );
      print('User Info3: ${userData.data}');
      return SignIn.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<GetGifting?> getGifting(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    print("Map : $body");
    try {
      Response userData = await _dio.post(
        ApiConstants.decryptData,
        data: body,
      );
      print('User Info3: ${userData.data}');
      return GetGifting.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<ForgotPassword?> forgotPass(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return ForgotPassword.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<VerifyOtp?> verifyOtp(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return VerifyOtp.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<VerifyForgotOtp?> verifyForgotOtp(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return VerifyForgotOtp.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<ResendModal?> resendOtp(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return ResendModal.fromJson(userData.data);
    } catch (e) {
      log("3 ${e.toString()}", error: e.toString());
      return null;
    }
  }

  Future<Setting?> setting(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return Setting.fromJson(userData.data);
    } catch (e) {
      log("3 ${e.toString()}", error: e.toString());
      return null;
    }
  }

  Future<NewPassword?> newPassword(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return NewPassword.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<InviteEmail?> inviteEmailSend(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return InviteEmail.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<GftrStories?> gftrStories(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};

    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      // print('-----------------User stories: ${userData.data}');
      return GftrStories.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<Allgifts?> All_My_Gifts(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('All my gifts: ${userData.data}');
      return Allgifts.fromJson(userData.data);
    } catch (e) {
      print("All my gifts error ${e.toString()}");
      return null;
    }
  }

  Future<DeleteFrd?> DeleteFrds(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('Delete friends: ${userData.data}');
      return DeleteFrd.fromJson(userData.data);
    } catch (e) {
      print("Delete friends Error ${e.toString()}");
      return null;
    }
  }

  Future<Deleteeventes?> DeletePreremainder(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('Delete friends: ${userData.data}');
      return Deleteeventes.fromJson(userData.data);
    } catch (e) {
      print("Delete friends Error ${e.toString()}");
      return null;
    }
  }

  Future<Glogin?> Goole_Login(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('Glogin: ${userData.data}');
      return Glogin.fromJson(userData.data);
    } catch (e) {
      print("Google login Error ${e.toString()}");
      return null;
    }
  }

  Future<RemoveEvent?> DeleteEvent(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('Delete friends: ${userData.data}');
      return RemoveEvent.fromJson(userData.data);
    } catch (e) {
      print("Delete friends Error ${e.toString()}");
      return null;
    }
  }

  Future<UpdateProfile?> updateProfile(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('profile: ${userData.data}');
      return UpdateProfile.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<ContactGftr?> contactGftr(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('User Info3: ${userData.data}');
      return ContactGftr.fromJson(userData.data);
    } catch (e) {
      print("3 ${e.toString()}");
      return null;
    }
  }

  Future<AddFolderModal?> addFolder(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("AddFolder : ${userdata.data}");
      return AddFolderModal.fromJson(userdata.data);
    } catch (e) {
      log("Add Folder : ${e.toString()}");
      return null;
    }
  }

  Future<RenameFolder?> renameFolder(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("AddFolder : ${userdata.data}");
      return RenameFolder.fromJson(userdata.data);
    } catch (e) {
      log("Add Folder : ${e.toString()}");
      return null;
    }
  }

  Future<MarkGift?> getmarkGifted(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("AddFolder : ${userdata.data}");
      return MarkGift.fromJson(userdata.data);
    } catch (e) {
      log("Add Folder : ${e.toString()}");
      return null;
    }
  }

  Future<UpadateInvite?> updateInvite(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("AddFolder : ${userdata.data}");
      return UpadateInvite.fromJson(userdata.data);
    } catch (e) {
      log("Add Folder : ${e.toString()}");
      return null;
    }
  }

  Future<AddForm?> addForm(String dataString) async {
    log('dataString : $dataString');
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("Add Form  data: ${userdata.data}");
      return AddForm.fromJson(userdata.data);
    } catch (e) {
      log("Add Form : ${e.toString()}");
      return null;
    }
  }

  Future<ViewGiftDelete?> viewDeleteGift(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("ViewGiftDelete : ${userdata.data}");

      return ViewGiftDelete.fromJson(userdata.data);
    } catch (e) {
      log("ViewGiftDelete : ${e.toString()}");

      return null;
    }
  }

  Future<ContactVerfy?> getVerifiedContact(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("getVerifiedContact : ${userdata.data}");
      return ContactVerfy.fromJson(userdata.data);
    } catch (e) {
      log("getVerifiedContact : ${e.toString()}");
      return null;
    }
  }

  Future<BuildGroup?> getBuilGroup(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("getBuilGroup : ${userdata.data}");
      return BuildGroup.fromJson(userdata.data);
    } catch (e) {
      log("getBuilGroup : ${e.toString()}");
      return null;
    }
  }

  Future<NoGroupData?> noGroups(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("No group : ${userdata.data}");
      return NoGroupData.fromJson(userdata.data);
    } catch (e) {
      log("no group error : ${e.toString()}");
      return null;
    }
  }

  Future<FolderDelete?> folderviewDelete(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      final userdata = await _dio.post(ApiConstants.decryptData, data: body);
      log("folderviewDelete : ${userdata.data}");
      return FolderDelete.fromJson(userdata.data);
    } catch (e) {
      log("folderviewDelete : ${e.toString()}");
      return null;
    }
  }

  Future<ViewGift?> viewGift(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('View Gift: ${userData.data}');
      return ViewGift.fromJson(userData.data);
    } catch (e) {
      print("View Gift ${e.toString()}");
      return null;
    }
  }

  Future<CalenderGet?> Calendar_events_view(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('Your Calendar Events : ${userData.data}');
      return CalenderGet.fromJson(userData.data);
    } catch (e) {
      print("Your Calendar Events Error ${e.toString()}");
      return null;
    }
  }

  Future<ViewAllUsers?> View_users(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('[][][]] =====> user is  : ${userData.data}');
      return ViewAllUsers.fromJson(userData.data);
    } catch (e) {
      print("=====> user is Error ${e.toString()}");
      return null;
    }
  }

  Future<Mutulfriendd?> GetMutualFrdS(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      log('mutual friend : ${userData.data}');
      return Mutulfriendd.fromJson(userData.data);
    } catch (e) {
      print("mutual friend Error ${e.toString()}");
      return null;
    }
  }

  Future<CalenderPost?> calendar_events(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('Calendar Events: ${userData.data}');
      return CalenderPost.fromJson(userData.data);
    } catch (e) {
      print("Calendar Events ${e.toString()}");
      return null;
    }
  }

  Future<MobileAuth?> Mobile_auth(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('Mobile_auth: ${userData.data}');
      return MobileAuth.fromJson(userData.data);
    } catch (e) {
      print("Mobile_auth ${e.toString()}");
      return null;
    }
  }

  Future<Groups?> getGroups(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      log('View Gift: ${userData.data}');
      return Groups.fromJson(userData.data);
    } catch (e) {
      print("View Gift error ${e.toString()}");
      return null;
    }
  }

  Future<GetContactList?> getContactList(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('GetContactList: ${userData.data}');
      return GetContactList.fromJson(userData.data);
    } catch (e) {
      print("GetContactList ${e.toString()}");
      return null;
    }
  }

  Future<Notifications?> MassageNotification(String dataString) async {
    var body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('Your Messages: ${userData.data}');
      return Notifications.fromJson(userData.data);
    } catch (e) {
      print("Your Messages error ${e.toString()}");
      return null;
    }
  }

  Future<PreRimend?> getpreRimend(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('getpreRimend: ${userData.data}');
      return PreRimend.fromJson(userData.data);
    } catch (e) {
      print("getpreRimend ${e.toString()}");
      return null;
    }
  }

  Future<ViewSetting?> viewSetting(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('viewSetting: ${userData.data}');
      return ViewSetting.fromJson(userData.data);
    } catch (e) {
      print("viewSetting ${e.toString()}");
      return null;
    }
  }

  Future<MyNotifications?> myNotification(String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('MyNotifications: ${userData.data}');
      return MyNotifications.fromJson(userData.data);
    } catch (e) {
      print("MyNotifications ${e.toString()}");
      return null;
    }
  }

  Future<GroupRequestReplyNotification?> groupRequestReplyNotification(
      String dataString) async {
    Map<String, dynamic> body = {"encData": dataString};
    try {
      Response userData = await _dio.post(ApiConstants.decryptData, data: body);
      print('GroupRequestReplyNotification: ${userData.data}');
      return GroupRequestReplyNotification.fromJson(userData.data);
    } catch (e) {
      print("GroupRequestReplyNotification ${e.toString()}");
      return null;
    }
  }
}
