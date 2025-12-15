#pragma once
using namespace System;

namespace SecurityApp {
    public ref class ComputerFailureType {
    private:
        String^ failureType;

    public:
        ComputerFailureType(String^ failureType);

        property String^ FailureType {
            String^ get();
            void set(String^ value);
        }
    };
}