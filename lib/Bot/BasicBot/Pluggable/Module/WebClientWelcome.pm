package Bot::BasicBot::Pluggable::Module::WebClientWelcome;

use strict;
use warnings;

use base 'Bot::BasicBot::Pluggable::Module';

sub help {
    "Greets users coming from the freenode web gateway"
}

sub chanjoin {
    my ( $self, $mess , $pri) = @_;
    my $user = $self->bot->pocoirc->nick_info( $mess->{who} );
    if ( index($user->{Host}, 'gateway/web/freenode') == 0 ) {
        $self->bot->say (
            who     => $mess->{who},
            channel => $mess->{channel},
            address => 1,
            body    => "Hi! Feel free to ask your question. Hopefully someone will be available soon to answer. Please, stick around!"
        );
    }
}

1;

