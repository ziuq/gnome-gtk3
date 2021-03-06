Gnome::Gtk3::TreePath
=====================

Description
===========

A struct that specifies a TreePath.

Synopsis
========

Declaration
-----------

    unit class Gnome::Gtk3::TreePath;
    also is Gnome::GObject::Boxed;

Types
=====

class N-GtkTreePath
-------------------

Methods
=======

new
---

Create a new default tree path object. This refers to a row.

    multi method new ( )

Create a new tree path with first index. The string representation of this path is “0”.

    multi method new ( Bool :first! )

Create a new tree path object using a string. Creates a new **Gnome::Gtk3::TreePath**-struct initialized to *$string*.

*$string* is expected to be a colon separated list of numbers. For example, the string “10:4:0” would create a path of depth 3 pointing to the 11th child of the root node, the 5th child of that 11th child, and the 1st child of that 5th child. If an invalid path string is passed in, the native object is undefined.

    multi method new ( Str :$string! )

Create a new tree path object using indices.

    multi method new ( Array :$indices! )

Create an object taking the native object from elsewhere.

    multi method new ( N-GtkTreePath :native-object! )

[[gtk_] tree_path_] to_string
-----------------------------

Generates a string representation of the path. This string is a “:” separated list of numbers. For example, “4:10:0:3” would be an acceptable return value for this string.

Returns: A newly-allocated string.

    method gtk_tree_path_to_string ( --> Str  )

[[gtk_] tree_path_] append_index
--------------------------------

Appends a new index to a path.

As a result, the depth of the path is increased.

    method gtk_tree_path_append_index ( Int $index )

  * Int $index; the index

[[gtk_] tree_path_] prepend_index
---------------------------------

Prepends a new index to a path.

As a result, the depth of the path is increased.

    method gtk_tree_path_prepend_index ( Int $index )

  * Int $index; the index

[[gtk_] tree_path_] get_depth
-----------------------------

Returns the current depth of *path*.

Returns: The depth of *path*

    method gtk_tree_path_get_depth ( --> Int  )

[[gtk_] tree_path_] get_indices
-------------------------------

Returns the current indices of *path*.

This is an array of integers, each representing a node in a tree. The length of the array can be obtained with `gtk_tree_path_get_depth()`.

Returns: An **Array** of the current indices, or `Any`

    method gtk_tree_path_get_indices ( --> Array )

[[gtk_] tree_path_] get_indices_with_depth
------------------------------------------

Returns the current indices of *path*.

This is an array of integers, each representing a node in a tree. It also returns the number of elements in the array.

Since: 3.0

    method gtk_tree_path_get_indices_with_depth ( --> List  )

Returns a list of

  * Int: number of elements returned in the integer array, or `Any`

  * Array: An Array with the current indices, or `Any`

[gtk_] tree_path_copy
---------------------

Creates a new **Gnome::Gtk3::TreePath**-struct as a copy of *path*.

Returns: a new **Gnome::Gtk3::TreePath**-struct

    method gtk_tree_path_copy ( --> N-GtkTreePath  )

[gtk_] tree_path_compare
------------------------

Compares two paths.

If this path appears before path `$c` in a tree, then -1 is returned. If `$c` appears before this node, then 1 is returned. If this path is equal to `$c`, then 0 is returned.

Returns: -1, 0 or 1

    method gtk_tree_path_compare ( N-GtkTreePath $c --> Int  )

  * N-GtkTreePath $c; a **Gnome::Gtk3::TreePath**-struct to compare with

[gtk_] tree_path_next
---------------------

Moves the *path* to point to the next node at the current depth.

    method gtk_tree_path_next ( )

[gtk_] tree_path_prev
---------------------

Moves the *path* to point to the previous node at the current depth, if it exists.

Returns: `1` if *path* has a previous node, and the move was made

    method gtk_tree_path_prev ( --> Int  )

[gtk_] tree_path_up
-------------------

Moves the *path* to point to its parent node, if it has a parent.

Returns: `1` if *path* has a parent, and the move was made

    method gtk_tree_path_up ( --> Int  )

[gtk_] tree_path_down
---------------------

Moves *path* to point to the first child of the current path.

    method gtk_tree_path_down ( )

[[gtk_] tree_path_] is_ancestor
-------------------------------

Returns `1` if *$descendant* is a descendant of this path or contained inside.

    method gtk_tree_path_is_ancestor ( N-GtkTreePath $descendant --> Int  )

  * N-GtkTreePath $descendant; another **Gnome::Gtk3::TreePath**-struct

[[gtk_] tree_path_] is_descendant
---------------------------------

Returns `1` if this path is a descendant of *$ancestor* or *$ancestor* contains this path somewhere below it

    method gtk_tree_path_is_descendant ( N-GtkTreePath $ancestor --> Int  )

  * N-GtkTreePath $ancestor; another **Gnome::Gtk3::TreePath**-struct

