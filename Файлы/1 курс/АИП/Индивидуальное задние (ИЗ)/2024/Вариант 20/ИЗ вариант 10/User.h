#pragma once

#include <string>
#include "ComputerFailureType.h"

using namespace System;
using namespace System::Collections::Generic;

namespace SecurityApp {
    public ref class User {
    private:
        String^ name;
        List<ComputerFailureType^>^ failureTypes;

    public:
        User(String^ name);

        property String^ Name {
            String^ get();
            void set(String^ value);
        }

        property List<ComputerFailureType^>^ FailureTypes {
            List<ComputerFailureType^>^ get();
        }

        void AddFailureType(ComputerFailureType^ failureType);
    };
}
