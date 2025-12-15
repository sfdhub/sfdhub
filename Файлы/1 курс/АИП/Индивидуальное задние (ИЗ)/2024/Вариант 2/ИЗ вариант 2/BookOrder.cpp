#include "BookOrder.h"

using namespace BookStoreApp;

BookOrder::BookOrder(String^ bookTitle) : bookTitle(bookTitle) {}

String^ BookOrder::BookTitle::get() {
    return bookTitle;
}

void BookOrder::BookTitle::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Book title cannot be empty");
    }
    bookTitle = value;
}
