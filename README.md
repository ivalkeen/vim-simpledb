postgres-vim
=

Vim plugin to execute postgresql commands from VIM buffer

Installation (Pathogen)
-

If you use git submodules, run this command from your .vim folder:

    git submodule add https://github.com/ivalkeen/vim-postgres bundle/postgres

Otherwise, , run this command from your .vim folder:

    git clone https://github.com/ivalkeen/vim-postgres bundle/postgres

Usage
-

Default key mapping for execution: `<enter>`.

1. Create new file with .sql extension (without extensions, mapping would not work)

2. Create first line with commented parameters for psql:

     `-- -h localhost -U postgres -d my_database`

  Note: if you don't want to enter password each time, you should create .pgpass file

3. Add sql statements to your file

4. Hit enter, to execute all not commented queries

TODO
-

1. Rewrite code to match vim script conventions
2. Intellisence
