# Some Special Tags in This System

## The "lnk" tag

    <lnk>http://some.where<l/>A link to somewhere</lnk>

This creates a link who's visible text is "A link to somewhere" that (when clicked)
directs the browser to open a new window (or tab, depending on how the browser is
configured) to the URL "http://some.where".

## The "bad" tag

The "bad" tag is identical to the "lnk" tag, except that it inserts the "rel" value
of "nofollow". Use this tag to reference a specific page who's search-engine rankings
you want to avoid helping.

# The "x" tag

    <x/>

Only valid in this form - this substitutes into an empty string.

Why do we have this tag at all? Because it is processed immediately after
triple-parantheses are replaced with fish-tags (for formats that make it burdensome
to type fish-tags - such as mobile soft keyboards).
Therefore, if you wish for literal triple-parantheses, simply insert this tag somewhere
that would interrupt them from being triple-parantheses to prevent them from being
replaced by fish-tags.

## The "title" tag

    <title>Title of the Article</title>

Use this to enclose the title of the article.
It gets replaced by a "div" element of class "my\_article\_title".

## The "fullcont" tag

Use this to enclose the full contents of the article (not including the title).
It gets replaced by a "div" element of class "my\_fullcont".

## The "precap" tag

Use this to enclose the bold text that is featured at the start of an
article - before the introduction.
It gets replaced by a "div" element of class "my\_precap".

## The "undivided" tag

If the article is not divided into sub-sections or chapters or any
other subdivisions, use this to enclose all the contents _except_
for what the "precap" tag encloses.
It gets replaced by a "div" element of class "my\_cont\_undivided".

## The "key" tag

If a span of text within a paragraph needs to be highlighted in bold
or whatever other alternative the blog's style uses for emphasized
text, enclose it in this element.
This will be replaced with a "span" element of class
"my\_keypoint".

