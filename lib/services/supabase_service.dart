import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() => _instance;

  SupabaseService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  // Auth

  Future<AuthResponse> signUp(String email, String password) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    return response;
  }

  Future<AuthResponse> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  Future<bool> userExists(String email) async {
    try {
      await _client.from('users').select().eq('email', email).single();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<dynamic> getUserById(String id) async {
    try {
      final user =
          await _client.from('users').select().eq('user_id', id).single();
      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  User? get currentUser => _client.auth.currentUser;

  // Database

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final response = await _client.from(table).select();
    return response;
  }

  Future<void> insertData(String table, Map<String, dynamic> data) async {
    await _client.from(table).insert(data);
  }

  Future<void> updateData(String table, Map<String, dynamic> data,
      String column, dynamic value) async {
    await _client.from(table).update(data).eq(column, value);
  }

  Future<void> deleteData(String table, String column, dynamic value) async {
    await _client.from(table).delete().eq(column, value);
  }

  // Storage

  Future<String> uploadFile(String bucket, String path, dynamic file) async {
    final response = await _client.storage.from(bucket).upload(path, file);
    return response;
  }

  Future<String> getPublicUrl(String bucket, String path) async {
    final url = _client.storage.from(bucket).getPublicUrl(path);
    return url;
  }

  Future<void> deleteFile(String bucket, String path) async {
    await _client.storage.from(bucket).remove([path]);
  }
}
