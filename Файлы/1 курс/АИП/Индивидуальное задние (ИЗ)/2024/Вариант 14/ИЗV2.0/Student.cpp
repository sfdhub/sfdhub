#include "Student.h"

using namespace StudentRecordApp;

Student::Student(String^ name, int id) : name(name), id(id) {
    recordBook = gcnew StudentRecordApp::RecordBook();
}

String^ Student::Name::get() {
    return name;
}

void Student::Name::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Name cannot be empty");
    }
    name = value;
}

int Student::Id::get() {
    return id;
}

void Student::Id::set(int value) {
    if (value <= 0) {
        throw gcnew ArgumentException("ID must be positive");
    }
    id = value;
}

StudentRecordApp::RecordBook^ Student::RecordBook::get() {
    return recordBook;
}
