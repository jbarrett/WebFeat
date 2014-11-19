package Bot::BasicBot::Pluggable::Module::DuckCoHelp;

use strict;
use warnings;

use base 'Bot::BasicBot::Pluggable::Module';

use HTTP::Tiny;
use HTML::TreeBuilder::XPath;

sub help {
    "!help <topic>"
}

sub told {
    my ( $self, $mess ) = @_;
    my $body = $mess->{body};
    return unless defined $body;
    return unless $body =~ /^!help (.*)/i;

    my $search_terms = $1;
    my $tree = HTML::TreeBuilder::XPath->new;
    my $response = HTTP::Tiny->new( timeout => 10 )->get(
        'https://duck.co/help/search?help_search=' . $search_terms
    );

    $tree->parse_content($response->{'content'});
    my @links = $tree->findnodes('/html/body//a[@class="linkbox  linkbox--result"]');
    return "No help for $search_terms" unless @links;

    my @toplinks = map { $_->attr('href') } @links[0..4];

    return "Top help results for $search_terms: " . join ' ', @toplinks;
}

1;

