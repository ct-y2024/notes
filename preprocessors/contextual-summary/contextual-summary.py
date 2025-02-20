#!/usr/bin/env python3

import sys
import json
import os
import pathlib

def process_book(book):
    for chapter in book['sections']:
        process_chapter(chapter, book['root'])
    return book

def process_chapter(chapter, book_root):
    if 'content' in chapter:
        file_path = chapter.get('path', None)
        if file_path:
            dir_name = pathlib.Path(file_path).parent.as_posix()  # Получаем директорию файла
            summary_path = None

            if dir_name == "Cpp":
                summary_path = os.path.join(book_root, "src", "Cpp", "SUMMARY.md")
            else:
                summary_path = os.path.join(book_root, "src", "SUMMARY.md")

            try:
                with open(summary_path, 'r', encoding='utf-8') as f:
                    summary_content = f.read()
                chapter['content'] = summary_content + "\n" + chapter['content']
            except FileNotFoundError:
                print(f"WARNING: SUMMARY.md not found at {summary_path}")


        if 'sub_items' in chapter and chapter['sub_items']:
            for sub_item in chapter['sub_items']:
                process_chapter(sub_item, book_root) # Рекурсивно обрабатываем под-главы


def main():
    # Читаем JSON данные, переданные mdBook
    book_json = sys.stdin.read()

    # Загружаем JSON в словарь Python
    book = json.loads(book_json)
    # Get the root directory (where the book.toml file is)
    book_root = os.path.dirname(os.path.abspath(sys.argv[1]))
    book['root'] = book_root

    # Обрабатываем книгу
    processed_book = process_book(book)

    # Выводим обработанный JSON обратно в stdout
    print(json.dumps(processed_book))

if __name__ == "__main__":
    main()
