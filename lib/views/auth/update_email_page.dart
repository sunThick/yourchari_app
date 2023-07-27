import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yourchari_app/constants/othes.dart';

import '../../constants/string.dart';
import '../../constants/void.dart';
import 'components/textdield_and_button_screen.dart';

class UpdateEmailPage extends StatelessWidget {
  const UpdateEmailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String newEmail = "";
    final TextEditingController controller = TextEditingController();
    return TextFieldAndButtonScreen(
      appbarTitle: updateEmailPageTitle,
      buttonText: updateEmailText,
      hintText: mailAddressText,
      controller: controller,
      onChanged: (value) => newEmail = value,
      onPressed: () async {
        final User user = returnAuthUser()!;
        await user.updateEmail(newEmail);
        showToast(msg: emailSendedMsg);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}
