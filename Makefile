DB_HOST?=127.0.0.1
DB_USER?=dbuser

init:
	@cockroach cert create-ca \
	--certs-dir=certs \
	--ca-key=ca.key
	@cockroach cert create-node \
	localhost \
	$(DB_HOST) \
	--certs-dir=certs \
	--ca-key=ca.key
	@cockroach cert create-client \
	root \
	--certs-dir=certs \
	--ca-key=ca.key

add-user:
	@cockroach cert create-client \
	$(DB_USER) \
	--certs-dir=certs \
	--ca-key=ca.key

list-certs:
	@cockroach cert list --certs-dir=certs

cleanup:
	@rm ./certs/*
	@rm ca.key