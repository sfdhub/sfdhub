#pragma once

#include "Order.h"

using namespace System;
using namespace System::Collections::Generic;

namespace AirlineApp {
    public ref class Customer {
    private:
        String^ name;
        int id;
        List<Order^>^ orders;

    public:
        Customer(String^ name, int id);

        property String^ Name {
            String^ get();
            void set(String^ value);
        }

        property int Id {
            int get();
            void set(int value);
        }

        property List<Order^>^ Orders {
            List<Order^>^ get();
        }
    };
}
