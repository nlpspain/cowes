#!/usr/bin/env python
import sys
from pathlib import Path

from blingfire import text_to_sentences


def main():
    wiki_dump_file_in = Path(sys.argv[1])
    wiki_dump_file_out = '{}/{}_preprocessed{}'.format(
        wiki_dump_file_in.parent,
        wiki_dump_file_in.stem,
        wiki_dump_file_in.suffix
    )

    print('Pre-processing {} to {}...'.format(wiki_dump_file_in, wiki_dump_file_out))
    with open(wiki_dump_file_out, 'w', encoding='utf-8') as out_f:
        with open(str(wiki_dump_file_in), 'r', encoding='utf-8') as in_f:
            for line in in_f:
                sentences = text_to_sentences(line)
                out_f.write(sentences + '\n')
    print('Successfully pre-processed {} to {}...'.format(wiki_dump_file_in, wiki_dump_file_out))


if __name__ == '__main__':
    main()