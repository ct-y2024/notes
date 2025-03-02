#set text(lang: "ru")

#set page(numbering: "1")

#let title(content, author) = align(
    center,
    text(17pt)[
        *#content*
    ]
        + linebreak()
        + text(13pt)[
            *#author*
        ]
        + linebreak()
        + datetime.today().display("[day].[month].[year]"),
)

#title("Парадигмы программирования", "Альжанов Леонид")

#outline(title: "Содержание", indent: 1em)

#pagebreak()
= Объектно-ориентированное программирование
#include "sections/java.typ"
#pagebreak()
= Информация о курсе
#include "sections/info.typ"
