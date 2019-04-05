#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

build_ontology() {
  cd src/ontology
  make
  make prepare_release
  cd ../..
}

commit_files() {
  git add ensembl-glossary.obo ensembl-glossary.owl
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER [skip travis]"
}

upload_files() {
  git remote add origin-upload https://${GH_TOKEN}@github.com/Ensembl/ensembl-glossary.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-upload master > /dev/null 2>&1
}

setup_git
build_ontology
commit_files
upload_files
