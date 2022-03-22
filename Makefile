secret_files := secret.txt secret2.txt
key_id := example_key_id
private_key_file = private.key

all: create_key encrypt

show_files:
	@echo "Encrypt files ${secret_files}"

help:
	@echo "Use make encrypt to encrypt files and make decrypt to decrypt files"

create_key:
	@echo "Check or create private key with key id '${key_id}'"
	@gpg --list-keys | grep ${key_id} || gpg --quick-gen-key --yes ${key_id}

encrypt: clean 
	@echo "Encrypt files ${secret_files} with key id '${key_id}'"
	@gpg -i --batch --recipient "${key_id}" --armor --encrypt-files ${secret_files}

export_key:
	@echo "Export private key to ${private_key_file}"
	@gpg --output ${private_key_file} --armor --export-secret-key "${key_id}"

import_key:
	@echo "Import private key from ${private_key_file}"
	@gpg --import ${private_key_file}

decrypt:
	gpg -d --batch --no-tty --encrypt-files ${secret_files}

clean:
	@echo "Remove encrypted files if exists"
	@rm -f *.asc
