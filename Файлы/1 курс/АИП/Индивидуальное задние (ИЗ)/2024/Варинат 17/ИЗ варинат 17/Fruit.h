#pragma once

using namespace System;

namespace WarehouseApp {
    public ref class Fruit {
    private:
        String^ name;

    public:
        Fruit(String^ name);

        property String^ Name {
            String^ get();
            void set(String^ value);
        }
    };
}
