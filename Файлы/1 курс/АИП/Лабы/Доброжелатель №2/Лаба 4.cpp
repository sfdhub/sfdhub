#include <iostream>
#include <fstream>
#include <string>     
using namespace std;

int main() {

    system("chcp 1251");
    string input;
    string max_word = "";
    int max_count = 0;

    ifstream in("in.txt"); 
    if (in.is_open())
    {
        while (getline(in, input))
        {
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
        }
        
        in.close();
        
    }
    ofstream out("out.txt");
    out << "Слова с максимальным количеством букв \"м\": \n" << max_word;
    out.close();
    return 0;
}