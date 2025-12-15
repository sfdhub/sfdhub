#include "User.h"

using namespace SecurityApp;

User::User(String^ name) : name(name) {
    failureTypes = gcnew List<ComputerFailureType^>();
}

String^ User::Name::get() {
    return name;
}

void User::Name::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Имя не может быть пустым");
    }
    name = value;
}

List<ComputerFailureType^>^ User::FailureTypes::get() {
    return failureTypes;
}

void User::AddFailureType(ComputerFailureType^ failureType) {
    failureTypes->Add(failureType);
}