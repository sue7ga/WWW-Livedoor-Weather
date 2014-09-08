package WWW::Livedoor::Weather;
use 5.008005;
use strict;
use warnings;
use LWP::UserAgent;
use Carp;
use XML::Simple;
use JSON;
use Encode;
use Furl;

our $VERSION = "0.01";

use Class::Accessor::Lite::Lazy(
  new     => 1,
  ro_lazy => [qw/furl/]
);

sub _build_furl{
  my $self = shift;
  return Furl->new(agent => 'WWW::Livedoor::Weather(Perl)',timeout => 10);
}

use constant BASE_URI => 'http://weather.livedoor.com/forecast';
use constant XML_URI => BASE_URI.'/rss/primary_area.xml';
use constant JSON_URI => BASE_URI.'/webservice/json/v1';

sub get{
    my($self,$city) = @_;
    my $cityid = do{
      if($city =~ /\d+/){
          $city;
      }else{
          $self->_get_cityid($city);
      }
    };
    my $url = JSON_URI."?city=$cityid";
    return $self->_parse_forecast($url);
}

sub _parse_forecast{
    my ($self,$url) = @_;
    my $res = $self->furl->get($url);
    return $self->_forecastmap($res->content);
}

sub _forecastmap{
    my($self,$json) = @_;
    my $ref;
    eval{$ref = JSON::decode_json($json)};
    croak('failed reading weather information'.$@) if $@;
    return $ref;
}

sub _get_cityid{
    my($self,$cityname) = @_;
    eval{$cityname = Encode::decode_utf8($cityname)};
    if($@){
      croak("cannot decode:$cityname".$@);
    }
    my $response = $self->furl->get(XML_URI);
    my $content = $response->content;
    $self->{citymap} = $self->_parse_citymap($content);
    return $self->{citymap}->{$cityname};
}

sub _parse_citymap{
    my($self,$content) = @_;
    my $ref = eval{
        local $XML::Simple::PREFERED_PARSER = 'XML::Parser';
        XMLin($content,ForceArray => [qw/area city/]);
    };
    if($@){
        croak('Oh! failed reading forecastmap:'.$@);
    }
    my %city;
    foreach my $area(@{$ref->{channel}->{'ldWeather:source'}->{pref}}){
        $city{$area->{city}->{$_}->{title}} = $_ for keys %{$area->{city}};
    }
    return \%city;
}

1;


__END__

=encoding utf-8

=head1 NAME

WWW::Livedoor::Weather - It's module that description livedoor weather.

=head1 SYNOPSIS

    use WWW::Livedoor::Weather;

    my $asahikawa = $weather->get('旭川');
        or 
    my $saitama   = $weather->get(110010);

    print $saitama->{link}; #=> 'http:/weather.livedoor.com/area/forecast/110010'
    print $saitama->{pinpointLocations}->[0]->{name}; #=> 'さいたま市'
    print $saitama->{forecast}->[0]->{dateLabel}; #=> '今日'
    print $saitama->{forecast}->[1]->{dateLabel}; #=> '明日'
    print $saitama->{location}->{area}; #=> '関東'    
   
   ----all cityies----
北海道地方
011000：稚内
012010：旭川
012020：留萌
016010：札幌
016020：岩見沢
016030：倶知安
013010：網走
013020：北見
013030：紋別
014010：根室
014020：釧路
014030：帯広
015010：室蘭
015020：浦河
017010：函館
017020：江差
青森県
020010：青森
020020：むつ
020030：八戸
岩手県
030010：盛岡
030020：宮古
030030：大船渡
宮城県
040010：仙台
040020：白石
秋田県
050010：秋田
050020：横手
山形県
060010：山形
060020：米沢
060030：酒田
060040：新庄
福島県
070010：福島
070020：小名浜
070030：若松
東京都
130010：東京
130020：大島
130030：八丈島
130040：父島
神奈川県
140010：横浜
140020：小田原
埼玉県
110010：さいたま
110020：熊谷
110030：秩父
千葉県
120010：千葉
120020：銚子
120030：館山
茨城県
080010：水戸
080020：土浦
栃木県
090010：宇都宮
090020：大田原
群馬県
100010：前橋
100020：みなかみ
山梨県
190010：甲府
190020：河口湖
新潟県
150010：新潟
150020：長岡
150030：高田
150040：相川
長野県
200010：長野
200020：松本
200030：飯田
富山県
160010：富山
160020：伏木
石川県
170010：金沢
170020：輪島
福井県
180010：福井
180020：敦賀
愛知県
230010：名古屋
230020：豊橋
岐阜県
210010：岐阜
210020：高山
静岡県
220010：静岡
220020：網代
220030：三島
220040：浜松
三重県
240010：津
240020：尾鷲
大阪府
270000：大阪
兵庫県
280010：神戸
280020：豊岡
京都府
260010：京都
260020：舞鶴
滋賀県
250010：大津
250020：彦根
奈良県
290010：奈良
290020：風屋
和歌山県
300010：和歌山
300020：潮岬
鳥取県
310010：鳥取
310020：米子
島根県
320010：松江
320020：浜田
320030：西郷
岡山県
330010：岡山
330020：津山
広島県
340010：広島
340020：庄原
山口県
350010：下関
350020：山口
350030：柳井
350040：萩
徳島県
360010：徳島
360020：日和佐
香川県
370000：高松
愛媛県
380010：松山
380020：新居浜
380030：宇和島
高知県
390010：高知
390020：室戸岬
390030：清水
福岡県
400010：福岡
400020：八幡
400030：飯塚
400040：久留米
大分県
440010：大分
440020：中津
440030：日田
440040：佐伯
長崎県
420010：長崎
420020：佐世保
420030：厳原
420040：福江
佐賀県
410010：佐賀
410020：伊万里
熊本県
430010：熊本
430020：阿蘇乙姫
430030：牛深
430040：人吉
宮崎県
450010：宮崎
450020：延岡
450030：都城
450040：高千穂
鹿児島県
460010：鹿児島
460020：鹿屋
460030：種子島
460040：名瀬
沖縄県
471010：那覇
471020：名護
471030：久米島
472000：南大東
473000：宮古島
474010：石垣島
474020：与那国島

=head1 DESCRIPTION

WWW::Livedoor::Weather is to know about weather all cities in Japan by using livedoor Weather API.

=head1 LICENSE

Copyright (C) sue7ga.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

sue7ga E<lt>sue77ga@gmail.comE<gt>

=cut

