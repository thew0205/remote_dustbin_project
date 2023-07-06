// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

// const kWifiSsidKey = "wifi_ssid_key";
// const kWifiPasswordKey = "wifi_password_key";
// const ip = "192.168.4.1";
// const ipWifi = "192.168.43.11";

// Future<bool> configureAccessPoint(String ssid, String password) async {
//   final response = await http.put(Uri.parse("http://$ip"));
//
@immutable
class ApiTemplate {
  final String ip;
  final bool isOpen;

  const ApiTemplate(
    this.ip,
    this.isOpen,
  );

  ApiTemplate copyWith({
    String? ip,
    bool? isOpen,
  }) {
    return ApiTemplate(
      ip ?? this.ip,
      isOpen ?? this.isOpen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ip': ip,
      'isOpen': isOpen,
    };
  }

  factory ApiTemplate.fromMap(Map<String, dynamic> map) {
    return ApiTemplate(
      map['ip'] as String,
      map['isOpen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiTemplate.fromJson(String source) =>
      ApiTemplate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApiTemplate(ip: $ip, isOpen: $isOpen)';

  @override
  bool operator ==(covariant ApiTemplate other) {
    if (identical(this, other)) return true;

    return other.ip == ip && other.isOpen == isOpen;
  }

  @override
  int get hashCode => ip.hashCode ^ isOpen.hashCode;
}

class ApiTemplateProvider extends StateNotifier<ApiTemplate> {
  ApiTemplateProvider(super.state);
  WebSocketChannel? _channel;
  final _client = http.Client();

  Future<bool> getConnection() async {
    try {
      final value = await _client.get(Uri.parse("http://${state.ip}"));
      if (value.statusCode == 200) {
        final wsUrl = Uri.parse('ws://${state.ip}:81');
        _channel = WebSocketChannel.connect(wsUrl);
        _channel?.ready.then((value) => _channel?.sink.add('0'));
        _channel?.stream.listen((message) async {
          // channel.sink.add('received!');
          try {
            // print(i++);
            final intReceived = int.tryParse(message) ?? -1;
            if (intReceived == 1 || intReceived == 0) {
              state = state.copyWith(isOpen: intReceived == 1);
            }
          } catch (e) {
            _channel?.sink.close();
          }
        });
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  void close() {
    _channel?.sink.close();
    setIp("");
  }

  void controlDustbin() {
    _channel?.sink.add(state .isOpen? '0' : '1');
  }

  void sendText(String state) {
    _channel?.sink.add(state[0]);
  }

  

  void setIp(String ip) {
    state = state.copyWith(ip: ip);
  }

  
}

final apiProvider = StateNotifierProvider.autoDispose<ApiTemplateProvider, ApiTemplate>(
    (ref) => ApiTemplateProvider(const ApiTemplate("", false)));
