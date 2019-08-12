TITLE
=====

Gnome::Gtk3::Border

SUBTITLE
========

A border around a rectangular area

Description
===========

A struct that specifies a border around a rectangular area that can be of different width on each side.

Synopsis
========

Declaration
-----------

    unit class Gnome::Gtk3::Border;
    also is Gnome::GObject::Boxed;

Example
-------

class N-GtkBorder
-----------------

A struct that specifies a border around a rectangular area that can be of different width on each side.

  * Int $.left: The width of the left border

  * Int $.right: The width of the right border

  * Int $.top: The width of the top border

  * Int $.bottom: The width of the bottom border

Methods
=======

new
---

### multi method new ( Bool :$empty! )

Create a new plain object. The value doesn't have to be True nor False. The name only will suffice.

### multi method new ( N-GtkBorder :border! )

Create an object taking the native object from elsewhere.

### multi method new ( Int :$left!, Int :$right!, Int :$top!, Int :$bottom! )

Create an object and initialize to given values.

left
----

Modify left width of border if value is given. Returns left value after modification if any, otherwise the currently set value.

    method left ( Int $value? --> Int )

right
-----

Modify right width of border if value is given. Returns right value after modification if any, otherwise the currently set value.

    method right ( Int $value? --> Int )

top
---

Modify top width of border if value is given. Returns top value after modification if any, otherwise the currently set value.

    method top ( Int $value? --> Int )

bottom
------

Modify bottom width of border if value is given. Returns bottom value after modification if any, otherwise the currently set value.

    method bottom ( Int $value? --> Int )

gtk_border_new
--------------

Allocates a new `Gnome::Gtk3::Border`-struct and initializes its elements to zero.

Returns: a newly allocated `Gnome::Gtk3::Border`-struct. Free with `gtk_border_free()`

Since: 2.14

    method gtk_border_new ( --> N-GtkBorder )

  * G_GNUC_MALLO $C;

gtk_border_copy
---------------

Copies a `Gnome::Gtk3::Border`-struct.

Returns: (transfer full): a copy of *border*.

    method gtk_border_copy ( --> N-GtkBorder  )

gtk_border_free
---------------

Frees a `N-GtkBorder` struct.

    method gtk_border_free ( )
