#pragma once
using namespace System;

namespace StudentRecordApp {
    public ref class Subject {
    private:
        String^ name;

    public:
        Subject(String^ name);

        property String^ Name {
            String^ get();
            void set(String^ value);
        }
    };
}
