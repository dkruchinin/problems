#!/usr/bin/env  python3


def list_div_pandigitals():
    divisors = [2, 3, 5, 7, 11, 13, 17]

    def dorec(pdn, rest, divs):
        pdn_str = str(pdn)
        if len(pdn_str) > 3:
            if int(pdn_str[-3:]) % divs[0] != 0:
                return []

            divs = divs[1:]
        if len(divs) == 0:
            return [pdn]
        if pdn < 0:
            pdn_str = ""

        pd_nums = []
        for i in range(0, len(rest)):
            pd_nums += dorec(int(pdn_str + rest[i]),
                             rest[:i] + rest[i+1:], divs)

        return pd_nums

    return dorec(-1, "0123456789", divisors)


if __name__ == '__main__':
    print(sum(list_div_pandigitals()))