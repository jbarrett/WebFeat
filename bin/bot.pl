#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Bot::BasicBot::Pluggable;

my $bot = Bot::BasicBot::Pluggable->new(
    channels => ["#duckduckgo"],
    server   => "irc.freenode.net",
    nick     => "WebFeat",
    name     => "A bot for ducks",
);

my $help = $bot->load('DuckCoHelp');

my $welcome = $bot->load('WebClientWelcome');

my $seen = $bot->load('Seen');

my $cpan = $bot->load('CPANLinks');

my $title = $bot->load('Title');

my $karma = $bot->load('Karma');
$karma->set('user_ignore_selfkarma' => 0);

$bot->run();

