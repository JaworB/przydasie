s = " Witaj świecie "

print(s.strip()) # usuwa miałe znaki z brzgów
print(s.lower()) # lower case
print(s.upper()) # upper case
print(s.replace("Świecie", "Pythone")) # zmienia A na B
print(s.len())  # długość stringa

zdanie = "Ala ma kota"
slowa = zdanie.split(" ") # dzieli string na elementy po separatorze
print(slowa)
print(" | ".join(slowa)) # odwrotność splita

print(zdanie[0]) # indeksowanie znaku  "A"
print(zdanie[4:6]) # slice - wycinek string - "ma"
print("kota" in zdanie) # sprawdzanie czy substring występuje -> True/False

# f-stringi - formatowanie liczb
cena = 19.999
print(f"Cena: {cena:.2f} zł") # zaokrąglenie do 2 miesjc - > cena 20.00 zł
print(f"{'tekst':>10}")  # wyrówanie do prawej - szerokość 10