use strict;
use warnings;
use Test::More;
use utf8;
use WWW::Livedoor::Weather;

my $weather = WWW::Livedoor::Weather->new();

my $saitama   = $weather->get(110010); # weather in Saitama

use Data::Dumper;
{
 package Data::Dumper;
 sub qquote {return shift;}
}
$Data::Dumper::Useperl = 1;

subtest 'link' => sub{
 is($saitama->{link},'http://weather.livedoor.com/area/forecast/110010');
};

subtest 'pinpointLocations' => sub{
 isa_ok $saitama->{pinpointLocations},'ARRAY';
 is_deeply $saitama->{pinpointLocations},[
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1110000',
            'name' => 'さいたま市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1120100',
            'name' => '川越市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1120300',
            'name' => '川口市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1120800',
            'name' => '所沢市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1120900',
            'name' => '飯能市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1121400',
            'name' => '春日部市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1121500',
            'name' => '狭山市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1121900',
            'name' => '上尾市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1122100',
            'name' => '草加市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1122200',
            'name' => '越谷市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1122300',
            'name' => '蕨市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1122400',
            'name' => '戸田市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1122500',
            'name' => '入間市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1122700',
            'name' => '朝霞市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1122800',
            'name' => '志木市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1122900',
            'name' => '和光市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1123000',
            'name' => '新座市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1123100',
            'name' => '桶川市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1123300',
            'name' => '北本市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1123400',
            'name' => '八潮市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1123500',
            'name' => '富士見市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1123700',
            'name' => '三郷市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1123800',
            'name' => '蓮田市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1123900',
            'name' => '坂戸市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1124000',
            'name' => '幸手市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1124100',
            'name' => '鶴ヶ島市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1124200',
            'name' => '日高市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1124300',
            'name' => '吉川市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1124500',
            'name' => 'ふじみ野市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1124600',
            'name' => '白岡市'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1130100',
            'name' => '伊奈町'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1132400',
            'name' => '三芳町'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1132600',
            'name' => '毛呂山町'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1132700',
            'name' => '越生町'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1134600',
            'name' => '川島町'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1144200',
            'name' => '宮代町'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1146400',
            'name' => '杉戸町'
          },
          {
            'link' => 'http://weather.livedoor.com/area/forecast/1146500',
            'name' => '松伏町'
          }
        ]; 
};

subtest 'forecasts' => sub{
  isa_ok $saitama->{forecasts},'ARRAY';
  is_deeply $saitama->{forecasts},[{
            'telop' => '晴時々曇',
            'dateLabel' => '今日',
            'date' => '2014-09-09',
            'image' => {
                         'width' => 50,
                         'url' => 'http://weather.livedoor.com/img/icon/2.gif',
                         'title' => '晴時々曇',
                         'height' => 31
                       },
            'temperature' => {
                               'min' => {
                                          'celsius' => 19,
                                          'fahrenheit' => '66.2'
                                        },
                               'max' => {
                                          'celsius' => 28,
                                          'fahrenheit' => '82.4'
                                        }
                             }
          },
          {
            'telop' => '曇時々晴',
            'dateLabel' => '明日',
            'date' => '2014-09-10',
            'image' => {
                         'width' => 50,
                         'url' => 'http://weather.livedoor.com/img/icon/9.gif',
                         'title' => '曇時々晴',
                         'height' => 31
                       },
            'temperature' => {
                               'min' => undef,
                               'max' => undef
                             }
          }
        ];
};

subtest 'location' => sub{
  is($saitama->{location}->{city},'さいたま');  
  is($saitama->{location}->{area},'関東');  
  is($saitama->{location}->{prefecture},'埼玉県');  
};

subtest 'publicTime' => sub{
 is($saitama->{publicTime},'2014-09-08T17:00:00+0900');
};

subtest 'copyright' => sub{
  is($saitama->{copyright}->{link},'http://weather.livedoor.com/');
  isa_ok $saitama->{copyright}->{provider},'ARRAY';
  is_deeply $saitama->{copyright}->{provider},[
                          {
                            'link' => 'http://tenki.jp/',
                            'name' => '日本気象協会'
                          }
                        ];
  is($saitama->{copyright}->{title},'(C) LINE Corporation');
  isa_ok $saitama->{copyright}->{image},'HASH';
  is_deeply $saitama->{copyright}->{image},{
                      'link' => 'http://weather.livedoor.com/',
                       'width' => 118,
                       'url' => 'http://weather.livedoor.com/img/cmn/livedoor.gif',
                       'title' => 'livedoor 天気情報',
                       'height' => 26
  };
};

done_testing;