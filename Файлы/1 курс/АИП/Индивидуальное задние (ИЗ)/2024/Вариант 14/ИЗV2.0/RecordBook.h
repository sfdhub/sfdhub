#pragma once

#include <vector>
#include "Subject.h"

using namespace System;
using namespace System::Collections::Generic;

namespace StudentRecordApp {
    public ref class RecordBook {
    private:
        int recordBookNumber;
        List<Subject^>^ subjects;

    public:
        RecordBook();

        property int RecordBookNumber {
            int get();
            void set(int value);
        }

        property List<Subject^>^ Subjects {
            List<Subject^>^ get();
        }

        void AddSubject(Subject^ subject);
    };
}
