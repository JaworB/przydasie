range_0_to_6 = range(6)
print("Zakres: ",list(range_0_to_6))

lenght = len(range_0_to_6)
print("Elementów w zakresie: ", lenght)

#Pętla while
print("==== pętla while - odliczanie ====")
index = 1
while index < len(range_0_to_6):
    print(index)
    index += 1

#Pętla for
print("==== pętla for - 6 x twojastara ====")
for i in range_0_to_6:
    print("twojastara")
print("Thats all folks")
