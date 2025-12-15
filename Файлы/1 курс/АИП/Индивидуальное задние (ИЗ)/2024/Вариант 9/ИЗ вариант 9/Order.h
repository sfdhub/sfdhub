#pragma once

#include <vector>
#include "DestinationOrder.h"

using namespace System;
using namespace System::Collections::Generic;

namespace TaxiApp {
    public ref class Order {
    private:
        int orderNumber;
        List<DestinationOrder^>^ destinationOrders;

    public:
        Order();

        property int OrderNumber {
            int get();
            void set(int value);
        }

        property List<DestinationOrder^>^ DestinationOrders {
            List<DestinationOrder^>^ get();
        }

        void AddDestinationOrder(DestinationOrder^ destinationOrder);
    };
}
