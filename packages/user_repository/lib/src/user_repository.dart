import 'dart:async';
import 'dart:io';

import 'package:growth_in_api/growth_in_api.dart';
import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/mappers/mappers.dart';
import 'package:user_repository/src/user_change_notifier.dart';
import 'package:user_repository/src/user_local_storage.dart';
import 'package:user_repository/src/user_secure_storage.dart';

class UserRepository {
  UserRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  })  : _secureStorage = const UserSecureStorage(),
        changeNotifier = UserChangeNotifier(),
        _localStorage = UserLocalStorage(noSqlStorage: noSqlStorage);

  final GrowthInApi remoteApi;
  final UserSecureStorage _secureStorage;
  final UserLocalStorage _localStorage;
  final BehaviorSubject<User?> _userSubject = BehaviorSubject();
  final UserChangeNotifier changeNotifier;
  final BehaviorSubject<LocalePreferenceDM?> _localePreferenceSubject =
      BehaviorSubject();

  Future<void> upsertLocalePreference(LocalePreferenceDM preference) async {
    await _localStorage.upsertLocalePreference(
      preference.toCacheModel(),
    );
    _localePreferenceSubject.add(preference);
  }

  Stream<LocalePreferenceDM?> getLocalePreference() async* {
    if (!_localePreferenceSubject.hasValue) {
      final storedPreferenceCM = await _localStorage.getLocalePreference();
      final storedPreference = storedPreferenceCM?.toDomainModel();
      // final storedPreference = LocalePreferenceCM.arabic.toDomainModel();
      if (storedPreferenceCM == null) {
        final String systemLocale = Platform.localeName;
        final defaultLocalePreference = strToLocalePreferenceDM(systemLocale);
        upsertLocalePreference(defaultLocalePreference);
      } else {
        _localePreferenceSubject.add(storedPreference);
      }
    }

    yield* _localePreferenceSubject.stream;
  }

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userRM = await remoteApi.auth.signIn(
        email: email,
        password: password,
      );
      // PII data should be stored in the secure storage
      await _secureStorage.upsertUser(
        id: userRM.info.id,
        name: userRM.info.name,
        email: userRM.info.email,
        phone: userRM.info.phone,
        countryCode: userRM.info.countryCode,
        image: userRM.info.image,
        token: userRM.token,
      );
      final user = userRM.toDomainModel();
      final userCompaniesCM = user.companies.toCacheModel();
      await _localStorage.upsertUserCompanies(
        userCompaniesCM,
      );
      return user;
    } catch (error) {
      if (error is InvalidCredentialsGrowthInException) {
        throw InvalidCredentialsException();
      }
      if (error is InvalidEmailFormatGrowthInException) {
        throw InvalidEmailFormatException();
      }
      rethrow;
    }
  }

  Future switchAccountCompany({
    required int companyId,
  }) async {
    try {
      final user = await getUser().first;
      await remoteApi.auth.chooseAccountCompany(
        companyId: companyId,
      );
      //update cached user companies
      final userCompanies = user!.companies
          .map(
            (company) {
              return company.copyWith(
                isSelected: company.id == companyId ? true : false,
              );
            },
          )
          .toList()
          .toCacheModel();
      await _localStorage.upsertUserCompanies(userCompanies);
      final updatedUser = user.copyWith(
        companies: userCompanies.toDomainModel(),
      );
      _userSubject.add(updatedUser);
    } catch (error) {
      if (error is CompanyNotAssociatedGrowthInException) {
        throw CompanyNotAssociatedException();
      }
      rethrow;
    }
  }

  Future<String> sendOtp(String email) async {
    try {
      final token = await remoteApi.auth.sendOtp(
        email: email,
      );
      await upsertOtpVerificationTokenSupplierToken(token);
      return token;
    } catch (error) {
      if (error is EmailNotRegisteredGrowthInException) {
        throw EmailNotRegisteredException();
      }
      rethrow;
    }
  }

  Future<int> reSendOtp() async {
    try {
      final isChangingEmail = changeNotifier.otpVerification!.isChangingEmail;
      final token = isChangingEmail
          ? await getUserToken()
          : await getOtpVerificationTokenSupplierToken();
      final totalTimeInMinutes =
          await remoteApi.auth.reSendOtp(otpVerificationToken: token!);
      return totalTimeInMinutes;
    } catch (error) {
      if (error is EmailNotRegisteredGrowthInException) {
        throw EmailNotRegisteredException();
      }
      rethrow;
    }
  }

  Future verifyOtp(
    String email,
    String otp,
  ) async {
    try {
      final forgotPasswordToken = await getOtpVerificationTokenSupplierToken();
      await remoteApi.auth.verifyOtp(
        token: forgotPasswordToken!,
        email: email,
        otp: otp,
      );
    } catch (error) {
      if (error is InvalidOtpGrowthInException) {
        throw InvalidOtpException();
      }
      rethrow;
    }
  }

  Future changeEmailOtpVerification({
    required String email,
    required String otp,
  }) async {
    try {
      final userToken = await getUserToken();
      await remoteApi.auth.changeEmailOtpVerification(
        userToken: userToken!,
        email: email,
        otp: otp,
      );
      final user = await getUser().first;
      final updatedUserCompanies = user?.companies.map(
        (company) {
          return company.copyWith(
            email: email,
          );
        },
      ).toList();
      await _secureStorage.upsertUser(
        id: user!.id,
        name: user.name,
        email: email,
        phone: user.phone,
        countryCode: user.countryCode,
        token: userToken,
      );
      await _localStorage.upsertUserCompanies(
        updatedUserCompanies!.toCacheModel(),
      );
      final updatedUser = user.copyWith(
        email: email,
        companies: updatedUserCompanies,
      );
      _userSubject.add(updatedUser);
    } catch (error) {
      if (error is InvalidOtpGrowthInException) {
        throw InvalidOtpException();
      }
      rethrow;
    }
  }

  Future<void> resetPassword({
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final otpVerificationToken = await getOtpVerificationTokenSupplierToken();
      await remoteApi.auth.resetPassword(
        otpVerificationToken: otpVerificationToken!,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future updateUser({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? jobTitle,
    String? image,
  }) async {
    try {
      final user = await getUser().first;
      await remoteApi.auth.updateProfile(
        userId: user!.id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        jobTitle: jobTitle,
        image: image,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      await remoteApi.auth.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
    } catch (error) {
      if (error is IncorrectPasswordGrowthInException) {
        throw WrongPasswordException();
      }
      rethrow;
    }
  }

  Future changeEmail({
    required String newEmail,
    required String newEmailConfirmation,
    required String password,
  }) async {
    try {
      await remoteApi.auth.changeEmail(
        newEmail: newEmail,
        newEmailConfirmation: newEmailConfirmation,
        password: password,
      );
    } catch (error) {
      if (error is IncorrectPasswordGrowthInException) {
        throw WrongPasswordException();
      }
      if (error is EmailAlreadyRegisteredGrowthInException) {
        throw EmailAlreadyRegisteredException();
      }
      rethrow;
    }
  }

  Future<String?> getUserToken() async => await _secureStorage.getUserToken();

  Future<String?> getOtpVerificationTokenSupplierToken() async =>
      await _secureStorage.getOtpVerificationTokenSupplierToken();

  Future upsertOtpVerificationTokenSupplierToken(String token) async =>
      await _secureStorage.upsertOtpVerificationTokenSupplierToken(
        token: token,
      );

  Future deleteOtpVerificationTokenSupplierString() async =>
      await _secureStorage.deleteOtpVerificationTokenSupplierString();

  Future logout() async {
    try {
      await _secureStorage.deleteUser();
      _userSubject.add(null);
    } catch (error) {
      rethrow;
    }
  }

  Stream<User?> getUser() async* {
    // Check if there is a [User] value added to the stream, if not,
    // this means that we need to first get the [User] data from
    // the secure storage in order to be able to add a [User].
    // if (!_userSubject.hasValue) {
    final userId = await _secureStorage.getUserId();
    final userName = await _secureStorage.getUserName();
    final userEmail = await _secureStorage.getUserEmail();
    final userPhone = await _secureStorage.getUserPhone();
    final userCountryCode = await _secureStorage.getUserCountryCode();
    final userImage = await _secureStorage.getUserImage();
    final userCompanies = await _localStorage.getUserCompanies();
    if (userId != null && userName != null) {
      final user = User(
        id: userId,
        name: userName,
        email: userEmail!,
        phone: userPhone!,
        countryCode: int.parse(userCountryCode!),
        image: userImage,
        companies: userCompanies!.toDomainModel(),
      );
      _userSubject.add(user);
    } else {
      _userSubject.add(null);
    }
    yield* _userSubject.stream;
  }

  Future cacheRememberedCredentials({
    required String email,
    required String password,
  }) async {
    await _secureStorage.upsertRememberEmail(email: email);
    await _secureStorage.upsertRememberPassword(password: password);
  }

  Future<RememberMe> getRememberedCredentials() async {
    final email = await _secureStorage.getRememberEmail();
    final password = await _secureStorage.getRememberPassword();
    final rememberMe = RememberMe(
      password: password,
      email: email,
    );
    return rememberMe;
  }

  Future deleteRememberedCredentials() async {
    await _secureStorage.deleteRememberEmail();
    await _secureStorage.deleteRememberPassword();
  }

  Future<List<Ticket>> getTickets() async {
    try {
      final ticketsRM = await remoteApi.auth.getTickets();
      final tickets =
          ticketsRM.map((ticketRM) => ticketRM.toDomainModel()).toList();
      return tickets;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TicketType>> getTicketsTypes() async {
    try {
      final cachedTickets = await _localStorage.getTicketTypes();
      if (cachedTickets != null) {
        return cachedTickets.toDomainModel();
      }

      final ticketsRM = await remoteApi.auth.getTicketsTypes();
      final ticketTypes = ticketsRM.toDomainModel();
      final ticketTypesCM = ticketsRM.toCacheModel();
      _localStorage.upsertTicketTypes(ticketTypesCM);
      return ticketTypes;
    } catch (error) {
      rethrow;
    }
  }

  Future submitTicket({
    required TicketType ticketType,
    required String ticketTitle,
    required String ticketDescription,
  }) async {
    try {
      await remoteApi.auth.submitTicket(
        ticketType: ticketType.name,
        ticketTitle: ticketTitle,
        ticketDescription: ticketDescription,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TicketMessage>> getTicketMessages(int ticketId) async {
    try {
      final ticketMessagesRM = await remoteApi.auth.getTicketMessages(ticketId);
      final ticketMessages = ticketMessagesRM.toDomainModel();
      return ticketMessages;
    } catch (error) {
      rethrow;
    }
  }

  Future createTicketMessage({
    required int ticketId,
    required String text,
    required File? file,
  }) async {
    try {
      await remoteApi.auth.createMessage(
        ticketId: ticketId,
        text: text,
        file: file,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<DateGroupedChats> getDateGroupedChats() async {
    final user = await getUser().first;
    final userSelectedCompanyId = user!.companies
        .firstWhere(
          (company) => company.isSelected,
        )
        .id;
    try {
      final dateGroupedChatsRM =
          await remoteApi.openLineChatApi.getChatMessages();
      final dateGroupedChats = dateGroupedChatsRM.toDomainModel();
      final dateGroupedChatsDM = dateGroupedChats.copyWith(
        list: dateGroupedChats.list
            .map(
              (chat) => chat.copyWith(
                messages: chat.messages.map(
                  (message) {
                    final isSentByMe =
                        message.sender.id == userSelectedCompanyId;
                    return message.copyWith(
                      isSentByMe: isSentByMe,
                    );
                  },
                ).toList(),
              ),
            )
            .toList(),
      );
      return dateGroupedChatsDM;
    } catch (error) {
      rethrow;
    }
  }

  Future sendChatMessage({
    required String message,
    List<File>? files,
  }) async {
    final user = await getUser().first;
    final companyId = user!.companies
        .firstWhere(
          (company) => company.isSelected,
        )
        .id;
    try {
      await remoteApi.openLineChatApi.sendMessage(
        companyId: companyId,
        message: message,
        files: files,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future initPusher() async {
    await remoteApi.pusherApi.initPusher();
  }

  Future subscribeToChat() async {
    final user = await getUser().first;
    final userSelectedCompanyId = user!.companies
        .firstWhere(
          (company) => company.isSelected,
        )
        .id;
    final chatSubscription = remoteApi.pusherApi.subscribeToChat(
      companyId: userSelectedCompanyId,
    );
    return chatSubscription;
  }

  Future<FormsDM> getForms() async {
    try {
      final formsRM = await remoteApi.formsApi.getForms();
      final forms = formsRM.toDomainModel();
      return forms;
    } catch (error) {
      rethrow;
    }
  }

  Future<FormsSections> getFormSections(int formId) async {
    try {
      final formSectionsRM = await remoteApi.formsApi.getFormSections(formId);
      final formSections = formSectionsRM.toDomainModel();
      return formSections;
    } catch (error) {
      rethrow;
    }
  }

  Future saveFormAnswers({
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      await remoteApi.formsApi.saveFormAnswers(answers);
    } catch (error) {
      rethrow;
    }
  }
}
