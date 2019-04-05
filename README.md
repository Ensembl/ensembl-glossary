[![Build Status](https://travis-ci.org/Ensembl/ensembl-glossary.svg?branch=master)](https://travis-ci.org/Ensembl/ensembl-glossary)

# ensembl-glossary

Ensembl glossary as an OWL ontology. 

# How To Edit

## Clone for the first time

```bash
git clone https://github.com/Ensembl/ensembl-glossary.git
```

The command will create `ensembl-glossary` in your working directory. You may need to switch to using the SSH version of the repository URL git@github.com:Ensembl/ensembl-glossary.git.

## Editing The File

First always pull in the latest changes from the repository origin. If you do this before each edit you'll avoid edit conflicts later on.

```bash
git pull
```

Now open the file `ensembl-glossary/src/templates/ontology.tsv` in Excel (or another spreadsheet engine), import as tab delimited data, edit and save. 

Once saved check what Git thinks you'll be committing back on the command line by using the `git diff` command. You can also use `git status` to get a summary of the changes.

```bash
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   src/templates/ontology.tsv

no changes added to commit (use "git add" and/or "git commit -a")

$ git diff src/templates/ontology.tsv
diff --git a/src/templates/ontology.tsv b/src/templates/ontology.tsv
index 6fb6ef5..a72a359 100644
--- a/src/templates/ontology.tsv
+++ b/src/templates/ontology.tsv
..... AFTER THIS YOU WILL SEE THE ACTUAL CHANGES ......
```

## Committing your changes and pushing these changes back

```bash
git add src/templates/ontology.tsv
git commit -m 'Enter your change message here'
git push origin
```

This will add the changes to `ontology.tsv` into your local Git repository and push those changes back to the GitHub hosted version.

## Building the ontology file (optional step)

**This step need only be run if you are building the ontology file locally and committing this into the repo. This should normally be handled by Travis-CI.**

```bash
cd src/ontology
make
make prepare_release
```

You will need Java8+ to run this builder.

# Other Repository Information

## Template

The ontology file is built from a spreadsheet template in [src/template/ontology.tsv](src/template/ontology.tsv)

### Editors' version

Editors of this ontology should use the edit version, [src/ontology/ensembl-glossary-edit.owl](src/ontology/ensembl-glossary-edit.owl)

# Contact

Please use this GitHub repository's [Issue tracker](https://github.com/simonjupp/ensembl-glossary/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

# Acknowledgements

This ontology repository was created using the [ontology starter kit](https://github.com/INCATools/ontology-starter-kit)
