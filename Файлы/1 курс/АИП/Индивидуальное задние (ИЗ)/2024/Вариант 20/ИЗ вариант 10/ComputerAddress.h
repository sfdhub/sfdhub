#pragma once

#include <string>
#include "User.h"

using namespace System;
using namespace System::Collections::Generic;

namespace SecurityApp {
    public ref class ComputerAddress {
    private:
        String^ address;
        List<User^>^ users;

    public:
        ComputerAddress(String^ address);

        property String^ Address {
            String^ get();
        }

        property List<User^>^ Users {
            List<User^>^ get();
        }

        void AddUser(User^ user);
    };
}