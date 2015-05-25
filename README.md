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

    There is also usefull key `-q` to avoid messages like 'Timing is on' etc.

3. Add sql statements to your file

4. Hit `<enter>` to execute all not commented queries

5. Hit `<leader><enter>` to execute all queries in the current paragraph

6. Select multiple lines in visual mode and hit `<enter>` to execute just those queries

## Configuration

If you do not want timings to be displayed, add this to your `.vimrc`:

    let g:simpledb_show_timing = 0


If you have any questions, [mail me](mailto:itkalin@gmail.com)

## TODO

1. Rewrite code to match vim script conventions
2. Intellisense

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Self-Promotion

If you like this project, please follow the repository on [GitHub](https://github.com/ivalkeen/vim-simpledb). You can also consider visiting my [blog](http://www.tkalin.com) and following me on [Twitter](https://twitter.com/ivalkeen) and [Github](https://github.com/ivalkeen).


[1]: http://i.imgur.com/1UrMOpd.png
[2]: https://github.com/kien/ctrlp.vim
[3]: https://github.com/gmarik/vundle

