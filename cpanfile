requires 'perl', '5.008001';
requires 'LWP::UserAgent';
requires 'XML::Simple';
requires 'JSON';
requires 'Furl';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

