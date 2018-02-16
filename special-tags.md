# Some Special Tags in This System

Remember - these tags are not processed by any actual XML processor.
Rather, it is simpler PERL functions. Hence, these tags do not have
any XML-type parameters - and a superfluous space within a tag can
make it unrecognizable to the parser.

## The "lnk" tag

    <lnk>http://some.where<l/>A link to somewhere</lnk>

This creates a link who's visible text is "A link to somewhere" that (when clicked)
directs the browser to open a new window (or tab, depending on how the browser is
configured) to the URL "http://some.where".

## The "bad" tag

The "bad" tag is identical to the "lnk" tag, except that it inserts the "rel" value
of "nofollow". Use this tag to reference a specific page who's search-engine rankings
you want to avoid helping.

## The "l" tags

There are two kinds of "l" tags.

### The first kind of "l" tag

The first is the self-contained "l" tag as
follows:

    <l/>

This tag is used between "lnk" tags as well as between "bad" tags to
indicate where the URL that a link directs to ends and the text of
the link begins.

### The second kind of "l" tag

The other is the separate "l" tags -- as follows:

    <l>http://some.where</l>

These kinds of "l" tags represent a link who's link-text is none other
than the URL it links to.

## The "x" tag

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

## Tags of the Psalms

### The "psalm" tag
This tag encases a psalm -- and is used instead of the "divided"
or "undivided" tag if the psalm is the entirety of the post.

### The "psalmbgn" tag
This tag is an alternative to the "psalm" tag when you are
not publishing a full psalm, but the mere beginning of the psalm
as a teaser. The closing-tag of this element will be followed
by the opening-tag of an "altlink" element.

### Tags for enclosing psalms.
Within a "psalm" tag, everything must be part of a stansa.
A psalm can have any number of stansas, but each one must be
enclosed in a tag for enclosing a psalm's stansa.
Even those psalms that begin with a line or so explaining
what the psalm is about or it's source, that too must be
enclosed in a stansa-appropriate tag.

#### The "pstans1" tag
For the typical stansa of a psalm. Generally, no stansa-wide indentation.

### Tags for enclosing lines within a psalm.
Text is also not to be out in the open within a stansa,
but must be part of a line.
Each line must be tag-enclosed to with a tag that
specifies what kind of line it is.

#### The "pvra1" tag
This is for lines that have no indentation beyond that of the stansa and which, in the case of responsive readings, are read by all participants.

#### The "pvrh1" tag
This is for lines that have no indentation beyond that of the stansa and which, in the case of responsive readings, are read only by the cantor.


