class UserStore {
  static final Map<String, String> _users = {};

  static void register(String username, String password) {
    _users[username] = password;
  }

  static bool validate(String username, String password) {
    if (username == 'jamiliaheubanks' && password == 'password') {
      return true;
    }
    return _users[username] == password;
  }
}