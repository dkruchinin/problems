#include <iostream>
#include <algorithm>
#include <vector>
#include <cstring>

struct sa_node {
    std::pair<int, int> bounds;
    int idx;
};

class SuffixArray {
private:
    const std::string *str;
    std::vector<std::vector<int>> sa_table;
    std::vector<int> sa;

    void init_suffix_array() {
        int len = str->size();

        int logN = 0;
        for (int k = 1; k < len; k <<= 1, logN++);
        if ((len & (len - 1)) == 0) {
            logN++;
        }

        sa_table.resize(logN);
        for (auto &v : sa_table) {
            v.resize(len);
        }

        auto mycmpfn = [&](const sa_node &a, const sa_node &b) -> bool {
            if (a.bounds.first != b.bounds.first) {
                return a.bounds.first < b.bounds.first;
            } else if (a.bounds.second >= 0 && b.bounds.second >= 0) {
                return a.bounds.second < b.bounds.second;
            } else {
                return a.idx > b.idx;
            }
        };

        std::vector<sa_node> sa_nodes(len);
        for(int i = 0; i < len; i++) {
            sa_table[0][i] = str->at(i);
        }
        for (int k = 1; k < logN; k++) {
            int off = 1 << (k - 1);

            for (int i = 0; i < len; i++) {
                int left = sa_table[k - 1][i];
                int right = i + off < len ? sa_table[k - 1][i + off] : -1;

                sa_nodes[i] = {
                    .bounds = std::make_pair(left, right),
                    .idx    = i
                };
            }

            std::sort(sa_nodes.begin(), sa_nodes.end(), mycmpfn);

            sa_table[k][sa_nodes[0].idx] = 0;
            for (int i = 1, rank = 0; i < len; i++) {
                rank += mycmpfn(sa_nodes[i - 1], sa_nodes[i]);
                sa_table[k][sa_nodes[i].idx] = rank;
            }
        }

        const std::vector<int> &inv_sa = sa_table[logN - 1];
        sa.resize(len);
        for (int i = 0; i < len; i++) {
            sa[inv_sa[i]] = i;
        }
    }

public:
    SuffixArray(const std::string &str) {
        this->str = &str;
        init_suffix_array();
    }

    const std::string &get_string() const {
        return *str;
    }

    std::string get_suffix(int i) {
        return str->substr(sa[i], str->size());
    }

    int lcp(int i, int j) const {
        int p_len = 0;
        int n = str->size();
        for (int k = sa_table.size() - 1; k >= 0 && i < n && j < n; k--) {
            if (sa_table[k][i] == sa_table[k][j]) {
                p_len += 1 << k;
                i += 1 << k;
                j += 1 << k;
            }
        }

        return p_len;
    }

    int size() const {
        return str->size();
    }
};

static const char DELIMITER = '#';

static std::string create_test_string(const std::string &str)
{
    std::string test_str = str;
    test_str.append(1, DELIMITER);

    std::string r_str = str;
    std::reverse(r_str.begin(), r_str.end());
    test_str.append(r_str);

    return test_str;
}

static int suffix_palindrome_len(const std::string &str)
{
    if (str.size() <= 1) {
        return 0;
    }

    std::string test_str = create_test_string(str);
    SuffixArray sa(test_str);

    int max_len_so_far = 1;
    int idx = 0;
    for (int i = 0; i < str.size(); i++) {
        int l = sa.lcp(i, test_str.size() - i - 1);
        if (i - l + 1 > 0 && i + l == str.size() && l * 2 - 1 > max_len_so_far) {
            max_len_so_far = l * 2 - 1;
            idx = i - l + 1;
        }

        if (i == 0) {
            continue;
        }

        l = sa.lcp(i, test_str.size() - i);
        if (i - l > 0 && i + l == str.size() && l * 2 > max_len_so_far) {
            max_len_so_far = l * 2;
            idx = i - l;
        }
    }

    return max_len_so_far;
}

int main(int argc, char *argv[])
{
    std::string in;
    std::cin >> in;

    int len = suffix_palindrome_len(in);
    std::string r_prefix = in.substr(0, in.size() - len);
    std::reverse(r_prefix.begin(), r_prefix.end());

    std::cout << in << r_prefix << std::endl;
    return 0;
}
