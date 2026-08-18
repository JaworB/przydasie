# --- if / elif / else ---

wiek = 32

if wiek < 18:
    print("niepełnoletni")
elif wiek < 65:
    print("dorosły")
else:
    print("senior")

# --- for po liście (jak foreach w PHP) ---
for owoc in ["jabłko", "gruszka", "śliwka"]:
    print(owoc)

# --- for z range() (jak klasyczna pętla for w PHP) ---
for i in range(5):        # 0,1,2,3,4
    print(i)

# --- while ---
licznik = 0
while licznik < 3:
    print(f"licznik = {licznik}")
    licznik += 1          # brak ++ w Pythonie

# --- break / continue ---
for i in range(10):
    if i == 3:
        continue
    if i == 7:
        break
    print(i)
