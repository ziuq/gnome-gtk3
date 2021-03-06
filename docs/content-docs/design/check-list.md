---
title: Check List
nav_menu: default-nav
sidebar_menu: design-sidebar
layout: sidebar
---

# Checklist

### Main documentation, subs and methods documentation
Legend for head of table

* T: type column
  * p: package name
  * t: is top level of classes,
  * b: boxed type
  * i: interface type
  * s: standalone type
  * N: native class
  * L: native library connection
  * not filled means standard class

* md: Module documentation
  * Title, description, see also, UML, synopsis
  * Inheritance when supported, example use
  * Remove interface information
* bd: Build documentation
  * Use test of `is-valid()` and ease of using `.set-native-object()`.
  * Remove check for wrong / unavailable options if inheritable.
  * Add =head3 to each `.new()` option.
  * Remove doc for :native-object or :build-id except where it is defined
  * Deprecate any option which can be done in a supsequent call like :$title in Window.
  * Move native `.gtk_..._new_...()` documentation to the Build doc. These subroutines must be prefixed with an underscore '\_' to make them unavailable, e.g. `._gtk_..._new_...()`.
* sd: Subroutine documentation and additions
  * Add examples to subroutines.
  * Inhibit unusable subroutines and documentation.
  * Add \$ to variables and use `True`/`False` when boolean input
  * Remove Since version text
  * Change `returns` into `-->`. Lower prio.
  * Provide single word method names. Lower prio.
  * Try to insert url references. Lower prio.
* cp: Cleanup documentation
  * Subroutines and Methods
  * Properties
  * Signals
  * Types
* ct: Testing
  * Complete `BUILD()` tests.
  * Complete subroutine tests
* pr: Priority
  * A star has more priority to finish than others

Entries can be
* x: Done or first letter of operation when not all applies
* #: No info
* Empty: Not done

| Module/Class            |T |md|bd|sd|cp|ct|pr|
|-------------------------|--|--|--|--|--|--|--|
**Gnome::Gtk3**           |p | #| #| #| #| #| #|
AboutDialog               |  | x| x|  |  |  |  |
AccelGroup                |
AccelLabel                |
AccelMap                  |
Accessible                |
Actionable                |i |
ActionBar                 |
Adjustment                |
AppChooserButton          |
AppChooser                |i |
AppChooserWidget          |
Application               |
ApplicationWindow         |
AspectFrame               |
Assistant                 |
Bin                       |
Border                    |b |
Box                       |
Buildable                 |i |
Builder                   |
Button                    |  | x| x|  |  |  |  |
ButtonBox                 |
Calendar|
CellArea|
CellAreaBox|
CellAreaContext|
CellEditable|i|
CellLayout|i|
CellRenderer|
CellRendererAccel|
CellRendererCombo|
CellRendererPixbuf|
CellRendererProgress|
CellRendererSpin|
CellRendererSpinner|
CellRendererText|
CellRendererToggle|
CellView|
CheckButton|
CheckMenuItem|
ChooserDialog|
Clipboard|
ColorButton|
ColorChooserDialog|
ColorChooser|i|
ColorChooserWidget|
ComboBox|
ComboBoxText|
Container|
CssProvider|
CssSection|b|
Dialog                    |  |  |  |  |  |  |* |
DrawingArea               |  | x| x| x| x| x|  |
Editable|i|
Entry|
EntryBuffer|
EntryCompletion|
EventBox|
EventController|
EventControllerKey|
EventControllerMotion|
EventControllerScroll|
Expander|
FileChooserButton|
FileChooserDialog|
FileChooser|i|
FileChooserWidget|
FileFilter|
Fixed|
FlowBox|
FlowBoxChild|
FontButton|
FontChooserDialog|
FontChooser|i|
FontChooserWidget|
Frame                     |  |  |  |  |  |  |* |
Gesture|
GestureDrag|
GestureLongPress|
GestureMultiPress|
GesturePan|
GestureRotate|
GestureSingle|
GestureStylus|
GestureSwipe|
GestureZoom|
GLArea|
Grid                      |  |  |  |  |  |  |* |
GtkOffscreenWindow|
GtkPlug|
GtkPrintUnixDialog|
GtkRecentChooserDialog|
GtkShortcutsWindow|
HandleBox|
HeaderBar|
IconFactory|
IconSet|b|
IconTheme|
IconView|
Image|
IMContext|
IMContextSimple|
IMMulticontext|
InfoBar|
Label|
Layout|
LevelBar|
LinkButton|
ListBox|
ListBoxRow|
ListStore|
LockButton|
Menu|
MenuBar|
MenuButton|
MenuItem|
MenuShell|
MenuToolButton|
MessageDialog|
ModelButton|
MountOperation|
Notebook|
Orientable|i|
Overlay|
PadController|
PageSetup|
PageSetupUnixDialog|
Paned|
PaperSize|b|
PlacesSidebar|
Popover|
PopoverMenu|
PrintBackend|
PrintContext|
Printer|
PrintJob|
PrintOperation|
PrintOperationPreview|i|
PrintSettings|
ProgressBar|
RadioButton|
RadioMenuItem|
RadioToolButton|
Range|
RcStyle|
RecentChooser|i|
RecentChooserMenu|
RecentChooserWidget|
RecentFilter|
RecentManager|
Requisition|b|
Revealer|
Scale|
ScaleButton|
Scrollable|i|
Scrollbar|
ScrolledWindow|
SearchBar|
SearchEntry|
SelectionData|b|
Separator|
SeparatorMenuItem|
SeparatorToolItem|
Settings|
ShortcutsGroup|
ShortcutsSection|
ShortcutsShortcut|
SizeGroup|
Socket|
SpinButton|
Spinner|
Stack|
StackSidebar|
StackSwitcher|
Statusbar|
StyleContext|
StyleProvider|i|
Switch|
TargetList|b|
TextBuffer|
TextChildAnchor|
TextIter|b|
TextMark|
TextTag|
TextTagTable|
TextView|
ToggleButton|
ToggleToolButton|
Toolbar|
ToolButton|
ToolItem|
ToolItemGroup|
ToolPalette|
ToolShell|i|
Tooltip|
TreeDragDest|i|
TreeDragSource|i|
TreeIter|b|
TreeModelFilter|
TreeModel|i|
TreeModelSort|
TreePath|b|
TreeRowReference|b|
TreeSelection|
TreeSortable|i|
TreeStore|
TreeView|
TreeViewColumn|
Viewport|
VolumeButton|
Widget                    |  |  |  |  |  |  |* |
WidgetPath|b|
Window                    |  | x| x|  |  |  |* |
WindowGroup|
**Gnome::Gdk3**           |p | #| #| #| #| #| #|
**Gnome::GObject**        |p | #| #| #| #| #| #|
Boxed                     |t |
Enums                     |s |
InitiallyUnowned          |
Object                    |t |  |  |  |  |  |* |
Signal                    |- |  |  |  |  |  |* |
Type                      |s |
value                     |b |
**Gnome::Glib**           |p | #| #| #| #| #| #|
Error                     |  |  |  |  |  |  |  |
List                      |  |  |  |  |  |  |  |
Main                      |  |  |  |  |  |  |  |
Quark                     |  |  |  |  |  |  |  |
SList                     |  |  |  |  |  |  |  |
Variant                   |  |  |  |  |  |  |  |
**Gnome::Gio**            |p | #| #| #| #| #| #|
Action                    |i |
ActionMap                 |i |
Application               |  |
EmblemedIcon              |  |
Enums                     |s |
File                      |i |
MenuModel                 |  |
MountOperation            |  |
Resource                  |b |
SimpleAction              |  |
**Gnome::N**              |p | #| #| #| #| #| #|
N-GObject                 |N |  |  |  |  |  |  |
NativeLib                 |L |  |  |  |  |  |- |
TopLevelClassSupport      |t |  |  |  |  |  |* |
X                         |  |  |  |  |  |  |* |

<!--
**Gnome::Atk**            |p | #| #| #| #| #| #|
Object                    |  |
-->
