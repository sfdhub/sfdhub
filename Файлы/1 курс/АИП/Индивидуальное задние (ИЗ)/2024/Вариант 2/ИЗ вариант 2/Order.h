#pragma once

#include <vector>
#include "BookOrder.h"

using namespace System;
using namespace System::Collections::Generic;

namespace BookStoreApp {
    public ref class Order {
    private:
        int orderNumber;
        List<BookOrder^>^ bookOrders;

    public:
        Order();

        property int OrderNumber {
            int get();
            void set(int value);
        }

        property List<BookOrder^>^ BookOrders {
            List<BookOrder^>^ get();
        }

        void AddBookOrder(BookOrder^ bookOrder);
    };
}
