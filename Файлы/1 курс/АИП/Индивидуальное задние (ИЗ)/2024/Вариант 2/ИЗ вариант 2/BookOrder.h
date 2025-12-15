#pragma once
using namespace System;

namespace BookStoreApp {
    public ref class BookOrder {
    private:
        String^ bookTitle;

    public:
        BookOrder(String^ bookTitle);

        property String^ BookTitle {
            String^ get();
            void set(String^ value);
        }
    };
}
