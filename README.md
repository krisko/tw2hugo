# tw2hugo
Convert json exported tiddles from tiddlywiki to hugo post

![twexport](/tiddlywikiExport.png)

## Tiddlywiki Advanced Filter

```sh
[!is[system]!sort[modified]limit[250]]
# filter out tags brands, regular, solid
[!is[system]!tag[brands]!tag[regular]!tag[solid]sort[title]]
```

## Categorize Tiddles in Hugo

```sh
# creates subfolder for each TAG and copies the hugo page
HUGOROOT=tw5
ls -1 imported | while read file; do
    TAG="$(grep ^tags "imported/$file" | cut -d\" -f2 | sort -u)" &&
    mkdir -p "$HUGOROOT/content/posts/$TAG" && 
    cp -v "imported/$file" "$HUGOROOT/content/posts/$TAG/"; done
```
