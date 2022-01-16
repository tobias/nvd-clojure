.PHONY: check-env

# Example usage:
# copy a temporary Clojars token to your clipboard
# GIT_TAG=v2.2.0 CLOJARS_USERNAME=$USER CLOJARS_PASSWORD=$(pbpaste) make deploy
# (recommended) delete said token.

deploy: check-env
	lein clean
	lein with-profile -user,-dev,+ci deploy clojars
	git tag -a "$$GIT_TAG" -m "$$GIT_TAG"
	git push
	git push --tags

check-env:
ifndef CLOJARS_USERNAME
	$(error CLOJARS_USERNAME is undefined)
endif
ifndef CLOJARS_PASSWORD
	$(error CLOJARS_PASSWORD is undefined)
endif
ifndef GIT_TAG
	$(error GIT_TAG is undefined)
endif
