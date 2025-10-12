abstract class UserRepository {
  Future<List<Map<String, dynamic>>> getAllUsers();
  Future<void> createUser(Map<String, dynamic> user);
  Future<Map<String, dynamic>?> isuser(String  email);
  Future<String> getEmailByKey (String key);
}
