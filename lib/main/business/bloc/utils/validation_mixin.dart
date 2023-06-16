mixin ValidationMixin {
  bool isFieldEmpty(String? fieldValue) => fieldValue?.isEmpty ?? true;

  bool validateMail(String? mail) {
    if (mail == null) {
      return false;
    } else {
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(mail);
    }
  }

  bool validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null) {
      return false;
    } else {
      return RegExp(
              r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(phoneNumber);
    }
  }

  bool validatePassword(String? pass) {
    if (pass == null) {
      return false;
    } else {
      return RegExp(
              r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!-\/:-@[-`{-~])[A-Za-z\d!-\/:-@[-`{-~]{8,}$')
          .hasMatch(pass);
    }
  }

  bool validatePasswordMatch(String? pass, String? repPass) {
    if (pass == repPass) {
      return true;
    } else {
      return false;
    }
  }

  bool validateIIN(String? iin) {
    if (iin == null) {
      return false;
    } else {
      return RegExp(r'\d{12}').hasMatch(iin);
    }
  }

  bool validateName(String? name) {
    if (name == null) {
      return false;
    } else {
      return RegExp(
              r"^([a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð]|[а-яёА-ЯЁ])+$",
              unicode: true)
          .hasMatch(name);
    }
  }

  bool validateBirthDate(String? inputBirthDate) {
    if (inputBirthDate != null) {
      DateTime birthDate = DateTime.parse(inputBirthDate);
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      int currentMonth = currentDate.month;
      int birthMonth = birthDate.month;
      if (birthMonth > currentMonth) {
        age--;
      } else if (birthMonth == currentMonth) {
        int currentDay = currentDate.day;
        int birthDay = birthDate.day;
        if (birthDay > currentDay) {
          age--;
        }
      }
      if (age <= 16) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
