# jordandcarter's fork

I have just simply added syntax highlighting for plpgsql (Never done that before, so not sure if it was the best approach, but it works)

# vim-simpledb

Vim plugin to execute postgresql or mysql commands from VIM buffer

## Installation

### Pathogen

If you use git submodules, run this command from your .vim folder:

    git submodule add https://github.com/ivalkeen/vim-simpledb bundle/simpledb

Otherwise, , run this command from your .vim folder:

    git clone https://github.com/ivalkeen/vim-simpledb bundle/simpledb

### Vundle

Add this line to your vimrc

    Bundle 'ivalkeen/vim-simpledb'

## Usage

Default key mapping for execution: `<enter>`.

1. Create new file with .sql extension (without extensions, mapping would not work)

2. Create first line with commented parameters:

    for psql:

    `-- -h localhost -U postgres -d my_database`

    or for mysql:

    `-- db:mysql -D my_database -u root`

    Note: if you don't want to enter password each time, you should create .pgpass (.my.cnf for mysql) file

3. Add sql statements to your file

4. Hit `<enter>` to execute all not commented queries

5. Hit `<leader><enter>` to execute all queries in the current paragraph

6. Select multiple lines in visual mode and hit `<enter>` to execute just those queries




If you have any questions, [mail me](mailto:itkalin@gmail.com)

## TODO

1. Rewrite code to match vim script conventions
2. Intellisense
