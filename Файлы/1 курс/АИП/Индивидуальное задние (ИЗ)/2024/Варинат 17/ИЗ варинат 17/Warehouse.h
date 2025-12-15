#pragma once

using namespace System;
using namespace System::Collections::Generic;

namespace WarehouseApp {
    public ref class Warehouse {
    private:
        String^ name;
        List<String^>^ fruits;

    public:
        Warehouse(String^ name);

        property String^ Name {
            String^ get();
            void set(String^ value);
        }

        property List<String^>^ Fruits {
            List<String^>^ get();
        }

        void AddFruit(String^ fruit);
    };
}
