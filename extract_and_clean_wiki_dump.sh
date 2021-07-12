#!/bin/sh
set -e

WIKI_DUMP_FILE_IN=$1
WIKI_DUMP_FILE_OUT=${WIKI_DUMP_FILE_IN%%.*}.txt
WIKI_TEMPLATES_FILE=eswiki.tpl

# extract and clean the chosen Wikipedia dump
echo "Extracting and cleaning $WIKI_DUMP_FILE_IN to $WIKI_DUMP_FILE_OUT..."
python -m wikiextractor.WikiExtractor  $WIKI_DUMP_FILE_IN --templates $WIKI_TEMPLATES_FILE -q -o - \
| grep -v "^<doc id=" \
| grep -v "</doc>\$" \
| sed "s/<.*>//g" \
| sed "/^\s*\$/d" \
| sed -r "s/\( *\)//g" \
> $WIKI_DUMP_FILE_OUT
echo "Succesfully extracted and cleaned $WIKI_DUMP_FILE_IN to $WIKI_DUMP_FILE_OUT"