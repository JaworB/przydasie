import subprocess

def streamuj_logi():
    # Uruchamiamy proces jako podproces. 
    # 'journalctl -f' oznacza "follow", czyli śledzenie zmian w czasie rzeczywistym.
    proces = subprocess.Popen(
        ['journalctl', '-f'], 
        stdout=subprocess.PIPE, 
        stderr=subprocess.PIPE,
        text=True
    )

    print("--- Nasłuchiwanie logów systemowych ---")
    
    # Iterujemy po strumieniu wyjściowym (stdout)
    for linia in proces.stdout:
        # Pętla for zatrzymuje się tutaj i czeka na nową linię od systemu
        print(f"Log: {linia.strip()}")

if __name__ == "__main__":
    try:
        streamuj_logi()
    except KeyboardInterrupt:
        print("\nZatrzymano nasłuchiwanie.")