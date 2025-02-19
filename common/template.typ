#set text(lang: "ru")

#let title(content, author) = align(center, text(17pt)[
  *#content*
] + linebreak() + 
text(13pt)[
  *#author*
] + linebreak() + 
datetime.today().display("[day].[month].[year]")
)