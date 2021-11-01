# Table Of Contents

<!-- toc -->

- [Adding stuff to the leftmost menu thing](#adding-stuff-to-the-leftmost-menu-thing)

<!-- tocstop -->

# Adding stuff to the leftmost menu thing

GtToolsMenu edit initializeElements.

add this as a children:


```smalltalk

			BrButton new
				aptitude: (BrGlamorousButtonWithLabelAptitude new);
				label: 'RPW';
				hMatchParent;
				action: [ :aButton | |rw|

				  rw := GtCoder forPackage: (RPWPillarTools package).
				  rw openInPagerFrom: aButton.  "gives us a coder in a new tab..."
				  "rw openInPager." "gives us a coder in a new tab"
                  "RPWPillarTools gtBrowse."
                  "GtCoder gtBrowse"

            ].

```
