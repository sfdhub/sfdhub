#include "Subject.h"

using namespace StudentRecordApp;

Subject::Subject(String^ name) : name(name) {}

String^ Subject::Name::get() {
    return name;
}

void Subject::Name::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Subject name cannot be empty");
    }
    name = value;
}
