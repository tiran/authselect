#!/bin/bash

zanata_push_before()
{
    # Update C pot file
    make -C "$PWD/po" update-po > /dev/null
    if [ $? -ne 0 ]; then
        exit 0
    fi
    
    # Update man pages pot files
    DIR="$PWD/src/man"
    for file in $DIR/*.adoc; do
        name=`basename $file`
        po4a-gettextize -f asciidoc -m $file -p "$DIR/po/$name.pot" > /dev/null
        if [ $? -ne 0 ]; then
            exit 1
        fi
    done
}

zanata_pull_after()
{
    # Translate man pages
    DIR="$PWD/src/man"
    for path in $DIR/po/*.po; do
        file=`basename $path`
        doc=`echo $file | sed -E 's/(.*)\.adoc\.[^.]+\.po/\1.adoc/'`
        lang=`echo $file | sed -E 's/.*\.adoc\.([^.]+)\.po/\1/'`
        po4a-translate -f asciidoc \
            --master "$DIR/$doc" \
            --po "$path" \
            --localized $DIR/translations/$lang/$doc \
            --keep 0 > /dev/null
        if [ $? -ne 0 ]; then
            exit 1
        fi
    done
}

case $1 in
push-before)
  zanata_push_before
  ;;
push-after)
  ;;
pull-before)
  ;;
pull-after)
  zanata_pull_after
  ;;
*)
  echo "Unknown parameter $1"
  exit 1
  ;;
esac

exit 0
