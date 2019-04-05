#!/bin/bash

function msg() {
  echo "travis-commit: $*"
}

function err() {
  msg "$*" 1>&2
}

function setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

function build_ontology() {
  cd src/ontology
  make
  make prepare_release
  cd ../..
}

function commit_files() {
  # Using https://gist.github.com/ddgenome/f3a60fe4c2af0cbe758556d982fbeea9 to get onto a real branch 
  # and not detached HEAD
  if ! git checkout "$TRAVIS_BRANCH"; then
    err "failed to checkout $TRAVIS_BRANCH"
    return 1
  fi
  local git_tag=SOME_TAG_TRAVIS_WILL_NOT_BUILD+travis$TRAVIS_BUILD_NUMBER
  if ! git tag "$git_tag" -m "Generated tag from Travis CI build $TRAVIS_BUILD_NUMBER"; then
    err "failed to create git tag: $git_tag"
    return 1
  fi
  
  git add ensembl-glossary.obo ensembl-glossary.owl
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER [ci skip]"
}

function upload_files() {
  if [[ $TRAVIS_BRANCH != master ]]; then
    msg "not pushing updates to branch $TRAVIS_BRANCH"
    return 0
  fi
  local remote=origin
  if [[ $GH_TOKEN ]]; then
    remote=https://$GH_TOKEN@github.com/$TRAVIS_REPO_SLUG
  fi
  msg "Pushing new commits to $TRAVIS_REPO_SLUG over HTTPS"
  if ! git push --quiet --follow-tags "$remote" "$TRAVIS_BRANCH" > /dev/null 2>&1; then
    err "failed to push git changes"
    return 1
  fi
}

setup_git

build_ontology

if ! commit_files; then
  exit 1
fi

if ! upload_files; then
  exit 1
fi
