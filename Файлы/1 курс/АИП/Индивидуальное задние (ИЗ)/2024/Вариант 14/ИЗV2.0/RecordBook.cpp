#include "RecordBook.h"

using namespace StudentRecordApp;

RecordBook::RecordBook() {
    subjects = gcnew List<Subject^>();
}

int RecordBook::RecordBookNumber::get() {
    return recordBookNumber;
}

void RecordBook::RecordBookNumber::set(int value) {
    if (value <= 0) {
        throw gcnew ArgumentException("Record book number must be positive");
    }
    recordBookNumber = value;
}

List<Subject^>^ RecordBook::Subjects::get() {
    return subjects;
}

void RecordBook::AddSubject(Subject^ subject) {
    subjects->Add(subject);
}
