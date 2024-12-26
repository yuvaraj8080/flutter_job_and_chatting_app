class Config {
  static const apiUrl = 'https://flutterjobandchattingserver-production.up.railway.app'; // Ensure this is correct
  static const String loginUrl = '/api/login';
  static const String signupUrl = '/api/register';
  static const String jobs = '/api/jobs';
  static const String search = '/api/jobs/search';
  static const String job = '/api/jobs';
  static const String profileUrl = '/api/users/';
  static const String getprofileUrl = '/api/users/';
  static const String bookmarkUrl = '/api/bookmarks';
  static const String chatsUrl = '/api/chats';
  static const String messagingUrl = '/api/messages';

  // Method to get full URL for a specific endpoint
  static Uri getFullUrl(String endpoint) {
    return Uri.parse('$apiUrl$endpoint');
  }
}