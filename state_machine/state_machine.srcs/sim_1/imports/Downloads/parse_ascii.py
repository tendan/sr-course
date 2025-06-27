written_seq = ''

with open("dane_testowe.txt", "r") as f:
    parsed_str = f.readline()
    for char in parsed_str:
        from_str_to_int = ord(char)
        bin_str = bin(from_str_to_int)[2:][::-1] # Wyklucz początek '0b'
        raw_seq = bin_str[:]
        uart_seq = '001' + bin_str[:] + '00' # uwzględnienie bitu startu i bitu stopu
        print(uart_seq, chr(int(raw_seq[::-1], 2)), bin(from_str_to_int))
        written_seq += uart_seq
        
with open("dane_python.txt", "w") as f:
    f.write(written_seq)