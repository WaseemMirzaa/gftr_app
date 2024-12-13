class AddToData{
  String id;
  String folderName;

  AddToData({required this.id,required this.folderName});
}
class ContactData{
  String? userName;
  String? phoneNumber;
  ContactData({ this.userName, this.phoneNumber});
  factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
    phoneNumber: json["phoneNumber"],
    userName: json["userName"],
  );
  }
