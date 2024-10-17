import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:rxdart/subjects.dart';

class PusherApi {
  PusherApi()
      : _pusher = PusherChannelsFlutter.getInstance(),
        chatSC = BehaviorSubject();

  final BehaviorSubject chatSC;
  final PusherChannelsFlutter _pusher;
  PusherChannel? _chatChannel;

  void subscribeToChannel({
    PusherChannel? pusherChannel,
    required String channelName,
    required Function onEvent,
  }) async {
    pusherChannel = _pusher.getChannel(channelName) ??
        await _pusher.subscribe(
          channelName: channelName,
          onEvent: onEvent,
        );
  }

  void subscribeToChat({required int companyId}) {
    subscribeToChannel(
      pusherChannel: _chatChannel,
      channelName: '${_ChannelNames.chat}.$companyId',
      onEvent: _chatEvent,
    );
  }

  void unsubscribeFromChannel(String channelName) async {
    await _pusher.unsubscribe(channelName: channelName);
    log('UNSUBSCRIBED SUCCESSFULLY FROM:::$channelName');
  }

  void unsubscribeFromChat({required int companyId}) async {
    unsubscribeFromChannel('${_ChannelNames.chat}.$companyId');
  }

  void _onSubscriptionSucceeded(String channelName, dynamic data) {
    log('SubscriptionSucceeded: $channelName data: $data');
  }

  void _onSubscriptionError(String message, dynamic e) {
    log('nSubscriptionError: $message Exception: $e');
  }

  void _onError(String message, int? code, dynamic e) {
    log('nError: $message code: $code exception: $e');
  }

  void _onDecryptionFailure(String event, String reason) {
    log('nDecryptionFailure: $event reason: $reason');
  }

  void _onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log('@@Connection: $currentState');
  }

  void _onMemberRemoved(String channelName, PusherMember member) {
    log('nMemberRemoved: $channelName user: $member');
  }

  Future<void> initPusher() async {
    try {
      await _pusher.init(
        apiKey: 'b3643b5243c6baad9466',
        cluster: 'eu',
        onError: _onError,
        onConnectionStateChange: _onConnectionStateChange,
        onDecryptionFailure: _onDecryptionFailure,
        onSubscriptionError: _onSubscriptionError,
        onMemberRemoved: _onMemberRemoved,
        onSubscriptionSucceeded: _onSubscriptionSucceeded,
      );
      await _pusher.connect();
    } catch (e) {
      log('Error connecting pusher::::::$e');
    }
  }

  Future<void> disconnectPusher() async {
    try {
      await _pusher.disconnect();
    } catch (e) {
      log('Error disconnecting pusher::::::$e');
    }
  }

  void _chatEvent(dynamic event) {
    Map<String, dynamic> data = json.decode(event.data);
    log('CHAT EVENT:::$data');
    // final OfferRM? offerRM = OfferRM.fromJson(data[_offerJsonKey]);
    // offerRM != null ? chatSC.add(offerRM) : chatSC.add(null);
  }
}

class _ChannelNames {
  const _ChannelNames._();

  static String get chat => 'chat';
}
