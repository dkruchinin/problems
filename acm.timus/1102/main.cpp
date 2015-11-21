#include <cstdio>
#include <string>
#include <cctype>

using namespace std;

static const int MAXSIZE = 10000000;

static bool is_dialog_line(const char *bytes, int len)
{
    if (len < 2) {
        return false;
    }

    int pos = len;
    while (pos > 0) {
        int p = pos - 2;
        if (p < 0) {
            return false;
        }
        if (bytes[p] == 'i' && bytes[p + 1] == 'n') {
            pos = p;
            continue;
        } else if (bytes[p] == 'n' && bytes[p + 1] == 'e') {
            if (p - 1 >= 0 && bytes[p - 1] == 'o') {
                pos = p - 1;
                continue;
            } else {
                return false;
            }
        } else if (bytes[p] == 'u' && bytes[p + 1] == 't') {
            if (--p < 0) {
                return false;
            }
            if (bytes[p] == 'o') {
                pos = p;
                continue;
            } else if (bytes[p] == 'p') {
                p -= 2;
                if (p < 0) {
                    return false;
                }
                if (bytes[p] == 'i' && bytes[p + 1] == 'n') {
                    pos = p;
                    continue;
                } else if (bytes[p] == 'u' && bytes[p + 1] == 't') {
                    p--;
                    if (p >= 0 && bytes[p] == 'o') {
                        pos = p;
                        continue;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } else if (bytes[p] == 'o' && bytes[p + 1] == 'n') {
            p -= 3;
            if (p >= 0 && bytes[p] == 'p' && bytes[p + 1] == 'u'
                && bytes[p + 2] == 't') {
                    pos = p;
                    continue;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    return true;
}

int main()
{
    char *line = new char[MAXSIZE];
    fgets(line, MAXSIZE, stdin);

    char c;
    int len = 0;
    while ((c = getchar()) != EOF) {
        if (isspace(c)) {
            if (is_dialog_line(line, len)) {
                printf("YES\n");
            } else {
                printf("NO\n");
            }

            len = 0;
        } else {
            line[len++] = c;
        }
    }

    delete[] line;
    return 0;
}
