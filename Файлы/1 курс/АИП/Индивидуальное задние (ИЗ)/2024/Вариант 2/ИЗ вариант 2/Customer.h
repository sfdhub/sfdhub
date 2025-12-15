#pragma once

#include <string>
#include "Order.h"

using namespace System;

namespace BookStoreApp {
    public ref class Customer {
    private:
        String^ name;
        int id;
        double discount;
        Order^ order;

    public:
        Customer(String^ name, int id, double discount);

        property String^ Name {
            String^ get();
            void set(String^ value);
        }

        property int Id {
            int get();
            void set(int value);
        }

        property double Discount {
            double get();
            void set(double value);
        }

        property Order^ Order {
            BookStoreApp::Order^ get();
        }
    };
}
