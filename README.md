# json2dot

Generate a .dot file from a .json file.
Then one can use graphviz to create
a visualization of the json structure.
Useful for teachers and authors to create
illustrations, quizzes, and other pedagogical materials.
Since almost all contemporary programming languages
support arrays and hashtables/dictionaries,
this program is useful not only for javascript
courses and documents, but also useful for
creating illustrations for tutorials for
perl, python, php, ruby, ...
 
## Installation

On lubuntu 16.04 (and I guess on \*buntu and on
any of the whole debian family), please do
`sudo apt-get install libjson-perl libfile-slurp-perl graphviz` .
Users of other distributions, please find the
corresponding packages in your distribution.
It may also work if you install these two perl modules from cpan instead.
The graphviz package is needed to process a .dot file into
a graphic file such as .svg or .jpg or .png .

Copy json2dot.pl to /usr/bin and make it executable.

## Usage

Try it out with the included sample file favourites.geojson:
`json2dot.pl favourites.geojson > favourites.dot ;
dot -Tsvg favourites.dot > favourites.svg`
Or using I/O redirections and pipes:
`./json2dot.pl < favourites.geojson | dot -Tsvg > favourites.svg`
Then open favourites.svg in your browser.
You maye need to manually fix line crossings using inkscape.

The sample file favourites.geojson was exported as
favourites.gpx from osmand, converted to .geojson
and manually edited to remove empty fields.

# json2dot

從一個 .json 檔產生一個 .dot 檔。
然後你可以用 graphviz 去處理這個 .dot 檔，
以便產生 .json 的資料結構圖。
對於老師及作者最有用， 可以拿來製作教學文件或考題的插圖。
因為當代許多程式語言都有陣列及雜湊/字典這兩種基本資料結構，
所以本程式不僅適用於 javascript 課程與文件，
也很適用於幫 perl、 python、 php、 ruby、 ... 等等語言的教學文製作插圖。

## 安裝

在 lubuntu 16.04 上 (我猜在 \*buntu 跟 debian 系列上面也一樣)
請下： `sudo apt-get install libjson-perl libfile-slurp-perl graphviz` 。
其他版本 linux 用戶請找到你的版本裡對應的套件。
或是直接從 cpan 安裝應該也可以。
至於 graphviz 則是要用來把 .dot 檔轉成 .svg/.jpg/.png 的工具。

把 json2dot.pl 拷貝到 /usr/bin 底下並且改成可執行。

## 使用

Try it out with the included sample file favourites.geojson:
請拿範例資料檔 favourites.geojson 來測試：
`json2dot.pl favourites.geojson > favourites.dot ;
dot -Tsvg favourites.dot > favourites.svg`
或是使用輸入輸出重新導向及 pipe：
`./json2dot.pl < favourites.geojson | dot -Tsvg > favourites.svg`
然後用瀏覽器開啟 favourites.svg 。
可能還需要用 inkscape 手工修飾一下交插的線。

範例資料檔 favourites.geojson 是從 osmand 的
favourites.gpx 轉檔出來的， 並且手工將空白的欄位移除。

