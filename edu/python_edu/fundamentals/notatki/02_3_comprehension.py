liczby = [1, 2, 3, 4, 5]

# --- list comprehension ---
# zwykła pętla:
kwadraty = []
for n in liczby:
    kwadraty.append(n ** 2)

# to samo jako list comprehension:
kwadraty = [n ** 2 for n in liczby]
print(kwadraty)              # [1, 4, 9, 16, 25]

# z warunkiem (filtrowanie):
parzyste = [n for n in liczby if n % 2 == 0]
print(parzyste)              # [2, 4]

# --- dict comprehension ---
slownik = {n: n ** 2 for n in liczby}
print(slownik)                # {1: 1, 2: 4, 3: 9, 4: 16, 5: 25}

# --- set comprehension ---
reszty = {n % 3 for n in liczby}
print(reszty)                 # {0, 1, 2} - duplikaty znikają jak zawsze w set

# lowercase każdego słowa po split:
zdanie = "Ala Ma Kota"
male = [slowo.lower() for slowo in zdanie.split()]
print(male)                    # ['ala', 'ma', 'kota']