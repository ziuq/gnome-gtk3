use v6;

unit class Gui;

use Gnome::GObject::Type;
use Gnome::GObject::Value;
use Gnome::Gtk3::Main;
use Gnome::Gtk3::Window;
use Gnome::Gtk3::Grid;
use Gnome::Gtk3::TreeView;
use Gnome::Gtk3::TreeViewColumn;
use Gnome::Gtk3::ListStore;
use Gnome::Gtk3::TreeStore;
use Gnome::Gtk3::CellRendererText;
use Gnome::Gtk3::TreePath;
use Gnome::Gtk3::TreeIter;

use GuiHandlers;

#use Gnome::N::X;
#Gnome::N::debug(:on);

#-------------------------------------------------------------------------------
enum FileListColumns <FILENAME_COL TODO_COUNT_COL DATA_KEY_COL>;
enum MarkerListColumns <MARKER_COL LINE_COL COMMENT_COL>;

has Gnome::Gtk3::Main $!main;
has Gnome::Gtk3::TreeView $!fs-table;
has Gnome::Gtk3::TreeStore $!files;
has Gnome::Gtk3::TreeView $!mark-table;
has Gnome::Gtk3::ListStore $!markers;

has Hash $!data-hash;

#-------------------------------------------------------------------------------
submethod BUILD ( ) {
  $!main .= new;
  $!data-hash = %();

  my Gnome::Gtk3::Window $w .= new(:title('Todo Viewer'));
  my Gnome::Gtk3::Grid $g .= new(:empty);
  $w.container-add($g);
  $w.container-set-border-width(10);
  $w.window-set-default-size( 270, 300);

  self!create-file-list-view;
  $g.grid-attach( $!fs-table, 0, 0, 1, 1);

  self!create-markers-list-view;
  $g.grid-attach( $!mark-table, 1, 0, 1, 1);

  my GuiHandlers::ListView $gh-flview .= new;
  $!fs-table.register-signal(
    $gh-flview, 'select-list-entry', 'row-activated',
    :data($!data-hash), :data-col(DATA_KEY_COL),
    :$!markers, :$!files
  );

  $!mark-table.register-signal(
    $gh-flview, 'select-marker-entry', 'row-activated', :$!markers
  );

  my GuiHandlers::Application $gh-app .= new(:$!main);
  $w.register-signal( $gh-app, 'exit-todo-viewer', 'destroy');

  $w.show-all;
}

#-------------------------------------------------------------------------------
method add-file-data (
  Str $base-name, Str $filename-path, Array $data
) {

  # only insert files which have data
  self!insert-in-table( "$base-name/$filename-path", $data)
    if $data.elems;
}

#-------------------------------------------------------------------------------
method activate ( ) {
  $!fs-table.tree-view-expand-all;
  Gnome::Gtk3::Main.new.gtk-main;
}

#-------------------------------------------------------------------------------
method !create-file-list-view ( ) {
  $!files .= new( :field-types( G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING));
  $!fs-table .= new(:model($!files));
  $!fs-table.tree-view-set-headers-visible(1);
  $!fs-table.widget-set-hexpand(1);
  $!fs-table.widget-set-vexpand(1);

  my Gnome::Gtk3::CellRendererText $crt .= new(:empty);
  my Gnome::GObject::Value $v .= new( :type(G_TYPE_STRING), :value<blue>);
  $crt.set-property( 'foreground', $v);
  my Gnome::Gtk3::TreeViewColumn $tvc .= new(:empty);
  $tvc.set-title('Filename');
  $tvc.pack-end( $crt, 1);
  $tvc.add-attribute( $crt, 'text', FILENAME_COL);
  $!fs-table.tree-view-append-column($tvc);

  $crt .= new(:empty);
  $v .= new( :type(G_TYPE_STRING), :value<blue>);
  $crt.set-property( 'foreground', $v);
  $tvc .= new(:empty);
  $tvc.set-title('Mark Count');
  $tvc.pack-end( $crt, 1);
  $tvc.add-attribute( $crt, 'text', TODO_COUNT_COL);
  $!fs-table.tree-view-append-column($tvc);

  $crt .= new(:empty);
  $tvc .= new(:empty);
  $tvc.set-visible(False);
  $tvc.pack-end( $crt, 1);
  $tvc.add-attribute( $crt, 'text', DATA_KEY_COL);
  $!fs-table.tree-view-append-column($tvc);
}

#-------------------------------------------------------------------------------
method !create-markers-list-view ( ) {
  $!markers .= new(
    :field-types( G_TYPE_STRING, G_TYPE_INT, G_TYPE_STRING)
  );
  $!mark-table .= new(:model($!markers));
  $!mark-table.tree-view-set-headers-visible(1);
  $!mark-table.widget-set-hexpand(1);
  $!mark-table.widget-set-vexpand(1);

  my Gnome::Gtk3::CellRendererText $crt .= new(:empty);
  my Gnome::GObject::Value $v .= new( :type(G_TYPE_STRING), :value<blue>);
  $crt.object-set-property( 'foreground', $v);
  my Gnome::Gtk3::TreeViewColumn $tvc .= new(:empty);
  $tvc.set-title('Marker');
  $tvc.pack-end( $crt, 1);
  $tvc.add-attribute( $crt, 'text', MARKER_COL);
  $!mark-table.tree-view-append-column($tvc);

  $crt .= new(:empty);
#  $v .= new( :type(G_TYPE_STRING), :value<blue>);
#  $crt.set-property( 'foreground', $v);
  $tvc .= new(:empty);
  $tvc.set-title('Line #');
  $tvc.pack-end( $crt, 1);
  $tvc.add-attribute( $crt, 'text', LINE_COL);
  $!mark-table.tree-view-append-column($tvc);

  $crt .= new(:empty);
  $v .= new( :type(G_TYPE_STRING), :value<blue>);
  $crt.set-property( 'foreground', $v);
  $tvc .= new(:empty);
  $tvc.set-title('Comment');
  $tvc.pack-end( $crt, 1);
  $tvc.add-attribute( $crt, 'text', COMMENT_COL);
  $!mark-table.tree-view-append-column($tvc);
}

#-------------------------------------------------------------------------------
method !insert-in-table ( Str $filename, Array $data ) {

  return unless ?$filename;
  my @path-parts = $filename.split('/');

  # sub to recursevly build the tree store from file and its data
  my Callable $s = sub ( @path-parts is copy, Array :$ts-iter-path is copy ) {

    my Bool $found = False;
    my Str $part = @path-parts.shift;
    my Gnome::Gtk3::TreeIter $iter;
    while ( ($iter = self!get-iter($ts-iter-path)).tree-iter-is-valid ) {

      my Array[Gnome::GObject::Value] $v =
         $!files.tree-store-get-value( $iter, FILENAME_COL);
      my Str $filename-table-entry = $v[0].get-string // '-';
      $v[0].unset;

      # Test if part is in the treestore at the provided path
      my Order $order = $part cmp $filename-table-entry;

      # Insert entry before this one and go a level deeper with the rest
      if $order == Less {
        $iter = $!files.tree-store-insert-before(
          self!get-parent-iter($ts-iter-path),      # parent
          self!get-iter($ts-iter-path)              # sybling
        );

        $!files.tree-store-set-value( $iter, FILENAME_COL, $part);

        if @path-parts.elems {
          $ts-iter-path.push(0);
          $s( @path-parts, :$ts-iter-path)
        }

        # Coming back from the top means that all is done only other
        # columns needs to set
        else {
          $!files.tree-store-set(
            $iter, TODO_COUNT_COL, "$data.elems()", DATA_KEY_COL, $filename
          );
          $!data-hash{$filename} = $data;
        }

        $found = True;
        last;
      }

      elsif $order == Same {
        # Part is found, go one level deeper if possible
        if @path-parts.elems {
          $ts-iter-path.push(0);
          $s( @path-parts, :$ts-iter-path);
        }

        # Coming back from the top means that all is done only other
        # columns needs to set
        else {
          $!files.tree-store-set(
            $iter, TODO_COUNT_COL, "$data.elems()", DATA_KEY_COL, $filename
          );
          $!data-hash{$filename} = $data;
        }

        $found = True;
        last;
      }

      else { # $order == More
        # Not found yet, try next entry
        $ts-iter-path[*-1]++;
      }
    }

    # Tree path in tree store is not found on this level => $iter not defined
    if !$found {
      $iter = self!get-parent-iter($ts-iter-path);
      $iter = $!files.tree-store-append($iter);

      $!files.tree-store-set-value( $iter, FILENAME_COL, $part);

      $ts-iter-path.push(0);
      if @path-parts.elems {
        $s( @path-parts, :$ts-iter-path)
      }

      else {
        $!files.tree-store-set(
          $iter, TODO_COUNT_COL, "$data.elems()", DATA_KEY_COL, $filename
        );
        $!data-hash{$filename} = $data;
      }
    }
  }

  # start inserting
  $s( @path-parts, :ts-iter-path([0]));
}

#-------------------------------------------------------------------------------
method !get-iter ( Array $store-location --> Gnome::Gtk3::TreeIter ) {

  my Gnome::Gtk3::TreePath $tp .= new(
    :string($store-location[0 .. *-1].join(':'))
  );

  $!files.tree-model-get-iter($tp)
}

#-------------------------------------------------------------------------------
method !get-parent-iter ( Array $store-location --> Gnome::Gtk3::TreeIter ) {
#note "GPI: ", $store-location.perl;
  my Gnome::Gtk3::TreeIter $parent-iter;
  if $store-location.elems > 1 {
    $parent-iter = $!files.tree-model-get-iter(
      Gnome::Gtk3::TreePath.new(:string($store-location[0 ..^ *-1].join(':')))
    );
  }

  else {
    $parent-iter .= new(:tree-iter(N-GtkTreeIter));
  }

  $parent-iter
}
