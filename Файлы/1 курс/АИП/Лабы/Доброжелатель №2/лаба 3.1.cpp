#include <iostream>
#include <string>

using namespace std;

int main() {
    system("chcp 1251");
    string input;
    cout << "Введите предложение: \n" ;
    getline(cin, input);
    int max_count = 0;
    string max_word = "";

    for (int i = 0; i < input.length(); i++) {
        if (input[i] == ' ') {
            continue;
        }
        string word = "";
        int count = 0;
        while (i < input.length() && input[i] != ' ') {
            word += input[i];
            if (input[i] == 'м' or input[i] == 'М') {
                count++;
            }
            i++;
        }
        if (count > max_count) {
            max_count = count;
            max_word = word;
        }
        else if (count == max_count) {
            max_word += ' ' + word;
        }
    }
    cout << "Слова с максимальным количеством букв 'м': ";
    cout << max_word << endl;

    return 0;
}
