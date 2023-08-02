import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'goBackHome': 'Return to Home',
          'home.genderLabel': 'Gender',
          'home.ageLabel': 'Age',
          'event': 'Add Event',
          'auth.sexFormField': 'Sex',
          'auth.ageFormField': 'Age',
          'auth.signInButton': 'Sign In',
          'auth.signUpButton': 'Sign Up',
          'auth.resetPasswordButton': 'Send Password Reset',
          'auth.emailFormField': 'Email',
          'auth.passwordFormField': 'Password',
          'auth.nameFormField': 'Name',
          'auth.signInErrorTitle': 'Sign In Error',
          'auth.signInError': 'Login failed: email or password incorrect.',
          'auth.resetPasswordLabelButton': 'Forgot password?',
          'auth.signUpLabelButton': 'Create an Account',
          'auth.signUpErrorTitle': 'Sign Up Failed.',
          'auth.signUpError':
              'There was a problem signing up.  Please try again later.',
          'auth.signInLabelButton': 'Have an Account? Sign In.',
          'auth.resetPasswordNoticeTitle': 'Password Reset Email Sent',
          'auth.resetPasswordNotice':
              'Check your email and follow the instructions to reset your password.',
          'auth.resetPasswordFailed': 'Password Reset Email Failed',
          'auth.signInonResetPasswordLabelButton': 'Sign In',
          'auth.updateUser': 'Update Profile',
          'auth.updateUserSuccessNoticeTitle': 'User Updated',
          'auth.updateUserSuccessNotice':
              'User information successfully updated.',
          'auth.updateUserEmailInUse':
              'That email address already has an account.',
          'auth.updateUserFailNotice': 'Failed to update user',
          'auth.enterPassword': 'Enter your password',
          'auth.cancel': 'Cancel',
          'auth.submit': 'Submit',
          'auth.changePasswordLabelButton': 'Change Password',
          'auth.resetPasswordTitle': 'Reset Password',
          'auth.updateProfileTitle': 'Update Profile',
          'auth.wrongPasswordNoticeTitle': 'Login Failed',
          'auth.wrongPasswordNotice':
              'The password does not match our records.',
          'auth.unknownError': 'Unknown Error',
          'settings.title': 'Settings',
          'settings.language': 'Language',
          'settings.theme': 'Theme',
          'settings.signOut': 'Sign Out',
          'settings.dark': 'Dark',
          'settings.light': 'Light',
          'settings.system': 'System',
          'settings.updateProfile': 'Update Profile',
          'home.title': 'Home',
          'home.nameLabel': 'Name',
          'home.uidLabel': 'UID',
          'home.emailLabel': 'Email',
          'home.adminUserLabel': 'Admin User',
          'app.title': 'Flutter Starter Project',
          'validator.email': 'Please enter a valid email address.',
          'validator.password': 'Password must be at least 6 characters.',
          'validator.name': 'Please enter a name.',
          'validator.number': 'Please enter a number.',
          'validator.notEmpty': 'This is a required field.',
          'validator.amount':
              'Please enter a number i.e. 250 - no dollar symbol and no cents',
          'today': 'Today',
          '+addtask': 'Add event',
          'rain': 'Rain',
          'TypeMessage': 'Send a message...',
          'send': 'Send',
          'chatRooms': 'Chat Rooms',
          'noChats': 'No chats available',
          'typeUser': 'Type username',
          'sayHi': 'Say Hi!',
          'searchUser': 'Search user',
          'signOut': 'Sign Out',
          'updateProfile': 'Update profile',
          'help': 'Help',
          'help.text': 'To contact support, please go to the chat page and search for "support". Text your issue and you will receive a response within 24 hours.',
          'wind': 'Wind',
          'humidy': 'Humidity',
          'currentLoc': 'Current location',
          'searchLoc': 'Search Location',
          'price': 'Price',
          'priced': 'Event price (in RON)',
          'title': 'Title',
          'titled': 'Event title',
          'loc': 'Location',
          'locd': 'Event location',
          'desc': 'Description',
          'descd': 'Event description',
          'createTask': 'Create event',
          'startTime': 'Start time',
          'endTime': 'End time',
          'color': 'Color',
          'date': 'Date',
          'hello': 'HELLO, log in to your account',
          'stats': 'Statistics',
          'statsEvent': 'Event statistics',
          'pressStats': 'Press on card for details',
          'noDetails': 'No information available at the moment',
          'averageAge': 'Average age:   ',
          'newUsers': 'New users: ',
          'oldUsers': 'Old users: ',
          'noOfMales': 'Number of males:   ',
          'noOfFemales': 'Number of females:   ',
          'listOfUsers': 'List of users',
          'pressDetails': 'Press here for details',
          'Gender.Male': 'Male',
          'Gender.Female': 'Female',
          'true': 'Yes',
          'false': 'No',
        },
        'ro': {
          'goBackHome': 'Intoarcere Acasă',
          'event': 'Adaugă eveniment',
          'auth.sexFormField': 'Gen',
          'auth.ageFormField': 'Vârstă',
          'auth.signInButton': 'Logare',
          'auth.signUpButton': 'Înregistrare',
          'auth.resetPasswordButton': 'Resetare parolă',
          'auth.emailFormField': 'Email',
          'auth.passwordFormField': 'Parolă',
          'auth.nameFormField': 'Nume',
          'auth.signInErrorTitle': 'Eroare la înregistrare',
          'auth.signInError': 'Logare eșuată: email sau parolă greșită',
          'auth.resetPasswordLabelButton': 'Ai uitat parola?',
          'auth.signUpLabelButton': 'Crează cont',
          'auth.signUpErrorTitle': 'Înregistrare eșuată',
          'auth.signUpError':
              'A apărut o problemă la înregistare. Revino mai târziu.',
          'auth.signInLabelButton': 'Ai deja cont? Loghează-te',
          'auth.resetPasswordNoticeTitle':
              'A fost trimis email-ul pentru resetarea parolei.',
          'auth.resetPasswordNotice':
              'Verifică email-ul și urmărește instrucțiunile pentru a-ți reseta parola',
          'auth.resetPasswordFailed': 'Resetarea parolei a eșuat',
          'auth.signInonResetPasswordLabelButton': 'Loghează-te',
          'auth.updateUser': 'Actualizează profilul',
          'auth.updateUserSuccessNoticeTitle': 'Utilizator actualizat',
          'auth.updateUserSuccessNotice':
              'Informațiile utilizatorului au fost actualizate cu succes.',
          'auth.updateUserEmailInUse':
              'Exista deja un cont cu această adresa de email',
          'auth.updateUserFailNotice': 'Actualizarea utilizatorului a eșuat',
          'auth.enterPassword': 'Introduceți parola',
          'auth.cancel': 'Anulează',
          'auth.submit': 'Trimite',
          'auth.changePasswordLabelButton': 'Schimbă parola',
          'auth.resetPasswordTitle': 'Resetează parola',
          'auth.updateProfileTitle': 'Actualizează profilul',
          'auth.wrongPasswordNoticeTitle': 'Logare eșuată',
          'auth.wrongPasswordNotice': 'Parolă greșită',
          'auth.unknownError': 'Eroare necunoscută',
          'settings.title': 'Setări',
          'settings.language': 'Limbă',
          'settings.theme': 'Temă',
          'settings.signOut': 'Delogare',
          'settings.dark': 'Noapte',
          'settings.light': 'Zi',
          'settings.system': 'Sistem',
          'settings.updateProfile': 'Actualizează profilul',
          'home.title': 'Acasă',
          'home.nameLabel': 'Nume',
          'home.uidLabel': 'UID',
          'home.emailLabel': 'Email',
          'home.adminUserLabel': 'Administrator',
          'app.title': 'Flutter Starter Project',
          'validator.email': 'Introduceți o adresă de email validă',
          'validator.password': 'Parola trebuie sa aibă minim 6 caractere',
          'validator.name': 'Introduceți un nume',
          'validator.number': 'Introduceți un număr',
          'validator.notEmpty': 'Acest câmp este obligatoriu',
          'validator.amount':
              'Vă rugăm alegeți un număr, de ex: 250 fără alte caractere',
          'today': 'Astăzi',
          '+addtask': 'Adaugă eveniment',
          'rain': 'Ploaie',
          'TypeMessage': 'Trimite un mesaj...',
          'send': 'Trimite',
          'chatRooms': 'Camere de Chat',
          'noChats': 'Nu există discuții disponibile',
          'typeUser': 'Tastați numele de utilizator',
          'sayHi': 'Spune Bună!',
          'searchUser': 'Caută utilizator',
          'signOut': 'Deconectare',
          'updateProfile': 'Actualizează profilul',
          'help': 'Ajutor',
          'help.text': 'Pentru a contacta serviciul de asistență, vă rugăm să accesați pagina de chat și să căutați "support". Scrieți problema dvs. și veți primi un răspuns în termen de 24 de ore.',
          'home.genderLabel': 'Gen',
          'home.ageLabel': 'Vârstă',
          'wind': 'Vânt',
          'humidy': 'Umiditate',
          'currentLoc': 'Locația curentă',
          'searchLoc': 'Caută Locația',
          'price': 'Preț',
          'priced': 'Preț eveniment (în RON)',
          'title': 'Titlu',
          'titled': 'Denumire eveniment',
          'loc': 'Locație',
          'locd': 'Locație eveniment',
          'desc': 'Descriere',
          'descd': 'Descriere eveniment',
          'createTask': 'Crează eveniment',
          'startTime': 'Ora de începere',
          'endTime': 'Ora de încheiere',
          'color': 'Culoare',
          'date': 'Dată',
          'hello': 'SALUT, loghează-te în contul tău',
          'stats': 'Statistici',
          'statsEvent': 'Statisticile evenimentului',
          'pressStats': 'Apasă pe card pentru detalii',
          'noDetails': 'Nu există informații momentan',
          'averageAge': 'Vârsta medie:   ',
          'oldUsers': 'Utilizatori vechi',
          'newUsers': 'Utilizatori noi',
          'noOfMales': 'Numărul de bărbați:   ',
          'noOfFemales': 'Numărul de femei:   ',
          'listOfUsers': 'Listă de utilizatori',
          'pressDetails': 'Apasă aici pentru detalii',
          'Gender.Male': 'Masculin',
          'Gender.Female': 'Feminin',
          'true': 'Da',
          'false': 'Nu',
        },
      };
}
