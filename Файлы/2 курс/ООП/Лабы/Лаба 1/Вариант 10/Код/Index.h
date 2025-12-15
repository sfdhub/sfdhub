#ifndef OOP_INDEX_H
#define OOP_INDEX_H

#include <string>
#include <vector>

using std::string;
using std::vector;

class Index {
private:
    string word;
    vector<int> pages;
public:
    Index(string word);
    Index operator+(const Index& index) const;
    ~Index();
    void setPages(vector<int> pages);
    int getPage(int index);
    long getPagesCount();
    string getWord();
    void addPage(int page);
};

#endif //OOP_INDEX_H
