class ApiConstants {
  //static const baseUrls = 'http://192.168.29.28:3330/';
  //static const baseUrls = 'https://backend.gftr.com/';
  static const baseUrls = 'https://dev-api.gftr.com/';
  //static const baseUrlsSocket = 'http://192.168.29.28:3330';
  // static const baseUrlsSocket = 'https://backend.gftr.com';
  static const baseUrlsSocket = 'https://dev-api.gftr.com';
  //Encode Data
  static const encodeData = '${baseUrls}encodeData';

  //Decrypt Data
  static const decryptData = '${baseUrls}decodeData';

  // Authentication
  static const signUp = '${baseUrls}signup';
  static const Mobileauth = '${baseUrls}updatephone';
  static const signIn = '${baseUrls}signin';
  static const verifyOtp = '${baseUrls}verifyOtp';
  static const resendOtp = '${baseUrls}resendOtp';
  static const forgotPassword = '${baseUrls}forgotPassword';
  static const verifyForgotOtp = '${baseUrls}verifyForgotOtp';
  static const newPassword = '${baseUrls}setNewPassword';
  static const updateProfile = '${baseUrls}updateProfile';
  static const logout = '${baseUrls}logout';
  static const contactGftr = '${baseUrls}contactgift';
  static const gftrStories = '${baseUrls}admin/viewblogswithitems';
  static const blogImageBasePath = '${baseUrls}uploads/blog';
  static const giftImageBasePath = '${baseUrls}uploads/gift';
  static const google_auth = '${baseUrls}auth/google';
  static const google_login = '${baseUrls}loginsuccess';

  //gift Manager
  static const editGiftNotes = '${baseUrls}editgiftnotes';
  static const editGiftNotesForIdeas = '${baseUrls}editgiftnotesformyideas';
  static const addFolder = '${baseUrls}addgift'; //post
  static const renameFolder = '${baseUrls}renamegift';
  static const deleteGift = '${baseUrls}deletegift';
  static const addtoForm = '${baseUrls}addtoform';
  static const viewgift = '${baseUrls}viewgift'; //get
  static const deleteForm = '${baseUrls}deleteform';
  static const getVerifiedContact = '${baseUrls}getVerifiedContact';
  static const folderSetting = '${baseUrls}folderSetting';
  static const getGifting = '${baseUrls}getGifting';
  static const buildGroup = '${baseUrls}buildGroup';
  static const myNotification = '${baseUrls}myNotification';
  static const updateInvite = '${baseUrls}updateInvite';
  static const verifiedContactList = '${baseUrls}verifiedContactList';
  static const groups = '${baseUrls}groups';
  static const groupRequestReply = '${baseUrls}groupRequestReply';
  static const markGift = '${baseUrls}markGift';
  static const settting = '${baseUrls}setting';
  static const viewSetting = '${baseUrls}viewSetting';
  static const inviteNewGftr = '${baseUrls}inviteNewGftr';
  static const preExistingHolidays = '${baseUrls}pre-existing-holidays';
  static const calendar_events = '${baseUrls}calenderevent';
  static const view_calendar_events = '${baseUrls}remindgevent';
  static const view_all_users = '${baseUrls}viewalluser';
  static const msg_notifocation = '${baseUrls}newmsg';
  static const User_img = '${baseUrls}addprofileimg';
  static const msg_seen = '${baseUrls}seenmsg';
  static const Mutul_friend = '${baseUrls}mutualfriend';
  static const Delete_frd = '${baseUrls}removefrd';
  static const No_Groups = '${baseUrls}nogroup';
  static const delete_event = '${baseUrls}removeevent';
  static const Delete_Preevent = '${baseUrls}deleteeventes';
  static const Get_Url = '${baseUrls}geturl';
  static const find_Email = '${baseUrls}findemail'; //
  static const all_gifts = '${baseUrls}allgift'; //
  static const cancel_request = '${baseUrls}cancelRequest'; //
  // static const cancel_request = '${baseUrls}decodeData/cancelRequest'; //
}
