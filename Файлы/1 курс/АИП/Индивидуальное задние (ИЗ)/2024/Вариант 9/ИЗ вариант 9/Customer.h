#pragma once

#include <string>
#include "Order.h"

using namespace System;

namespace TaxiApp {
    public ref class Customer {
    private:
        String^ name;
        double discount;
        Order^ order;

    public:
        Customer(String^ name, double discount);

        property String^ Name {
            String^ get();
            void set(String^ value);
        }

        property double Discount {
            double get();
            void set(double value);
        }

        property Order^ Order {
            TaxiApp::Order^ get();
        }
    };
}
