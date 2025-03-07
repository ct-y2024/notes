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

#show raw.where(block: false): box.with(
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
)
#show raw.where(block: true): block.with(
    inset: 5pt,
    radius: 4pt,
    stroke: 1pt,
)

#title("Парадигмы программирования", "Альжанов Леонид")

#outline(title: "Содержание", indent: 1em)

#pagebreak()
= Объектно-ориентированное программирование
#include "sections/java.typ"
= Введение в JavaScript
#include "sections/javascript.typ"
#pagebreak()
= Информация о курсе
#include "sections/info.typ"
