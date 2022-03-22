secret_files := secret.txt secret2.txt
recipient := ${RECIPIENT}

show_files:
	@echo "Encrypt files ${secret_files}"

all: show_files help

help:
	@echo "Use make encrypt to encrypt files and make decrypt to decrypt files"

encrypt: show_files clean
	gpg -i --batch --recipient "${recipient}" --armor --encrypt-files ${secret_files}

decrypt:
	gpg --batch --no-tty --encrypt-files ${secret_files}

clean:
	rm -f *.asc
