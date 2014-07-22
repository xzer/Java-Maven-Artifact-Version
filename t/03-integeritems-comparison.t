#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Java::Maven::Artifact::Version;

plan tests => 7;

BEGIN {
  my $v = Java::Maven::Artifact::Version->new('1');

  #test 1 : integeritem with integeritem - inferiority
  is($v->compare_to(2), -1);

  #test 2 : integeritem with integeritem - superiority
  $v = Java::Maven::Artifact::Version->new(2);
  is($v->compare_to(1), 1);
  
  #test 3 : integeritem with integeritem - equality
  is($v->compare_to(2), 0);

  #test 4 : integeritem with stringitem - superiority
  $v = Java::Maven::Artifact::Version->new('1.1');
  is($v->compare_to('1-m1'), 1);

  #test 5 : integeritem with listitem - superiority
  is($v->compare_to('1-1'), 1);

  #test 6 : integeritem with nullitem - case of superiority
  $v = Java::Maven::Artifact::Version->new('1.1.1');
  is($v->compare_to('1.ga.1'), 1);
  
  #test 7 : integeritem with nullitem - case of equality
  $v = Java::Maven::Artifact::Version->new('1.0.1');
  is($v->compare_to('1..1'), 0); #_replace_alias do the job
}

diag( "Testing integer items comparison Java::Maven::Artifact::Version $Java::Maven::Artifact::Version::VERSION feature" );
