# json2dot
Generate a .dot file from a .json file.
Then one can use graphviz to create
a visualization of the json structure.
Useful for teachers and authors to create
illustrations, quizzes, and other pedagogical materials.

## Installation

On lubuntu 16.04, please do
`apt-get install libjson-perl libfile-slurp-perl graphviz` .
It may also work if you install these two perl modules from cpan.
The graphviz package is needed to process a .dot file into
a graphic file such as .svg or .jpg or .png .

Copy json2dot.pl to /usr/bin and make it executable.

## Usage

Try it out with the included sample file favourites.geojson:
`json2dot.pl favourites.geojson > favourites.dot ;
dot -Tsvg favourites.dot > favourites.svg`
Then open favourites.svg in your browser.
You maye need to manually fix line crossings using inkscape.

