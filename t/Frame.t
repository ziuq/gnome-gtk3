use v6;
use NativeCall;
use Test;

use Gnome::GObject::Type;
use Gnome::GObject::Value;
use Gnome::Gtk3::Frame;
use Gnome::Gtk3::Enums;
use Gnome::Gtk3::Label;

#use Gnome::N::X;
#Gnome::N::debug(:on);

#-------------------------------------------------------------------------------
my Gnome::Gtk3::Frame $f;
#-------------------------------------------------------------------------------
subtest 'ISA test', {
  $f .= new;
  isa-ok $f, Gnome::Gtk3::Frame, '.new()';

  $f .= new(:label('frame label'));
  isa-ok $f, Gnome::Gtk3::Frame, '.new(:label)';
}

#-------------------------------------------------------------------------------
subtest 'Manipulations', {
  $f.set-label('blah');
  is $f.get-label, 'blah', '.set-label() / .get-label()';

  my Gnome::Gtk3::Label $l .= new(:native-object($f.get-label-widget));
  is $l.get-text, 'blah', '.get-label-widget()';

  # create a label without parent, previous one has frame as a parent!
  $l .= new(:text('new label'));
  $f.set-label-widget($l);
  is $f.get-label, 'new label', '.set-label-widget()';

  $f.set-label-align( 0.8e0, 0.03e0);
  my Num ( $xa, $ya) = $f.get-label-align;
  is-approx $xa, 0.8e0, '.get-label-align() xalign ok';
  is-approx $ya, 0.03e0, '.get-label-align() yalign ok';

  $f.set-shadow-type(GTK_SHADOW_IN);
  is GtkShadowType($f.get-shadow-type), GTK_SHADOW_IN,
    '.set-shadow-type() / .get-shadow-type()';
}

#-------------------------------------------------------------------------------
subtest 'Properties ...', {
  my Gnome::GObject::Value $gv .= new(:init(G_TYPE_STRING));
  $f.g-object-get-property( 'label', $gv);
  is $gv.get-string, 'new label', 'property label';
  $gv.clear-object;

  $gv .= new(:init(G_TYPE_FLOAT));
  $f.g-object-get-property( 'label-xalign', $gv);
  is-approx $gv.get-float, 0.8e0, 'property label-xalign';
  $gv.clear-object;

  $gv .= new(:init(G_TYPE_FLOAT));
  $f.g-object-get-property( 'label-yalign', $gv);
  is-approx $gv.get-float, 0.03e0, 'property label-yalign';
  $gv.clear-object;
}

#`{{
#-------------------------------------------------------------------------------
subtest 'Inherit ...', {
}

#-------------------------------------------------------------------------------
subtest 'Interface ...', {
}

#-------------------------------------------------------------------------------
subtest 'Themes ...', {
}

#-------------------------------------------------------------------------------
subtest 'Signals ...', {
}
}}

#-------------------------------------------------------------------------------
done-testing;
