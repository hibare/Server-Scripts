import argparse

def read_file(filename):
    """
    Reads key-value pairs from a file and returns a dictionary.
    """
    data = {}
    with open(filename, 'r') as file:
        for line in file:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            key, value = line.strip().split('=')
            data[key.strip()] = value.strip()
    return data

def update_file(source_file, destination_file):
    """
    Updates key-value pairs in destination_file with values from source_file,
    and appends any new key-value pairs from source_file to destination_file.
    """
    source_data = read_file(source_file)
    destination_data = read_file(destination_file)

    for key, value in source_data.items():
        destination_data[key] = value

    with open(destination_file, 'w') as file:
        for key, value in destination_data.items():
            file.write(f"{key}={value}\n")

def main():
    parser = argparse.ArgumentParser(description='Update key-value pairs in destination file with values from source file.')
    parser.add_argument('--source', type=str, required=True, help='Path to source file')
    parser.add_argument('--destination', type=str, required=True, help='Path to destination file')
    args = parser.parse_args()

    update_file(args.source, args.destination)

if __name__ == "__main__":
    main()
