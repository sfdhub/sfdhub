#pragma once

#include <string>
#include "RecordBook.h"

using namespace System;

namespace StudentRecordApp {
    public ref class Student {
    private:
        String^ name;
        int id;
        RecordBook^ recordBook;

    public:
        Student(String^ name, int id);

        property String^ Name {
            String^ get();
            void set(String^ value);
        }

        property int Id {
            int get();
            void set(int value);
        }

        property RecordBook^ RecordBook {
            StudentRecordApp::RecordBook^ get();
        }
    };
}
