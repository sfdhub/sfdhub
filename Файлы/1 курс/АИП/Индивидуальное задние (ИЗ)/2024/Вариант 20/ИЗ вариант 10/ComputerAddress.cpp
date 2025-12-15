#include "ComputerAddress.h"

using namespace SecurityApp;

ComputerAddress::ComputerAddress(String^ address) : address(address) {
    users = gcnew List<User^>();
}

String^ ComputerAddress::Address::get() {
    return address;
}

List<User^>^ ComputerAddress::Users::get() {
    return users;
}

void ComputerAddress::AddUser(User^ user) {
    users->Add(user);
}
