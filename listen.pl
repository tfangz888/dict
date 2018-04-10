#!/usr/bin/perl

print "listen.pl  tmp1.txt 3\n";
use Time::HiRes qw(usleep nanosleep);
# $youdao_address = '/home/toby/dict/youdao/british/';
$youdao_address = '/home/toby/dict/youdao/american/';
$webster_address = '/home/toby/dict/webster/';
$lingoes_address = "/home/toby/dict/lingoes/";
$lemma_address = "/home/toby/mp3/lemma/words/american/";
$play_times = 1;
$num_args = $#ARGV + 1;
$debug = 0;
$slow = 1;
if ($num_args > 1)
{
    $play_times = $ARGV[1];
}
if ($debug)
{
    print $num_args, "\n";
    print $play_times, "\n";
}
while(<>)
{
    chomp;
    $word = $_;
    $word =~ s/^\s+|\s+$//g;
    if ($debug)
    {
        print $word, "\n";
    }
    # print substr($word, 0, 1), "\n";
    if (length($word) > 1)
    {
        $word_youdao_address = $youdao_address .  $word . ".mp3"; #没考虑大小写
        $word_webster_address = $webster_address . lc(substr($word, 0, 1)) . "/" .  $word . ".wav";
        $word_lingoes_address = $lingoes_address . lc(substr($word, 0, 1)) . "/" .  $word . ".mp3";
        $word_lemma_address = $lemma_address . lc(substr($word, 0, 1)) . "/" .  $word . ".mp3";
        
        print $word, "\n";
        if ($debug)
        {
            print $word_webster_address, "\n";
        }
        $time_i = $play_times;
        if (-e $word_youdao_address)
        {
            while ($time_i-- > 0)
            {            
                $start_time = (`date +%s~` * 1000) + int(`date +%N` / 1000000);	            
                if ($debug)
                {
                    print $start_time, "\n";
                }
                # system("muinshee --play " . $word_youdao_address);
                # mpg321 application.mp3 -q --stereo --loop 3
                system("mpg321 -q --stereo " . $word_youdao_address);
                $end_time = (`date +%s~` * 1000) + int(`date +%N` / 1000000);
                if ($debug)
                {
                    print $end_time, "\n";
                }
                $period = $end_time - $start_time;
                while ($period < 0)
                {
                    $period += 1000;
                }
                if ($debug)
                {
                    print $period, "\n";
                }
                if ($slow)
                {
                    usleep($period * 1000);
                }
            }
        }
        elsif (-e $word_webster_address)
        {
            while ($time_i-- > 0)
            {            
                if ($debug)
                {
	                print "time_i =", $time_i, "\n";
                }
                $start_time = (`date +%s~` * 1000) + int(`date +%N` / 1000000);
                if ($debug)
                {
                    print $start_time, "\n";
                }
                # system("banshee --play " . $word_webster_address);
                # print $word_webster_address, "\n";
                # `banshee --play $word_webster_address`;
#                system("aplay $word_webster_address");
                my $msg = `aplay $word_webster_address > /dev/null  2>&1`;
                $end_time = (`date +%s~` * 1000) + int(`date +%N` / 1000000);
                if ($debug)
                {
                    print $end_time, "\n";
                }
                $period = $end_time - $start_time;
                while ($period < 0)
                {
                    $period += 1000;
                }
                if ($debug)
                {
                    print $period, "\n";
                }
                if ($slow)
                {
                    usleep($period * 1000);
                }
            }
        }
        elsif (-e $word_lingoes_address)
        {
            while ($time_i-- > 0)
            {            
                $start_time = (`date +%s~` * 1000) + int(`date +%N` / 1000000);	            
                if ($debug)
                {
                    print $start_time, "\n";
                }
                # system("muinshee --play " . $word_lingoes_address);
                # mpg321 application.mp3 -q --stereo --loop 3
                system("mpg321 -q --stereo " . $word_lingoes_address);
                $end_time = (`date +%s~` * 1000) + int(`date +%N` / 1000000);
                if ($debug)
                {
                    print $end_time, "\n";
                }
                $period = $end_time - $start_time;
                while ($period < 0)
                {
                    $period += 1000;
                }
                if ($debug)
                {
                    print $period, "\n";
                }
                if ($slow)
                {
                    usleep($period * 1000);
                }
            }
        }
        elsif (-e $word_lemma_address)
        {
            while ($time_i-- > 0)
            {            
                $start_time = (`date +%s~` * 1000) + int(`date +%N` / 1000000);	            
                if ($debug)
                {
                    print $start_time, "\n";
                }
                # system("muinshee --play " . $word_lemma_address);
                # mpg321 application.mp3 -q --stereo --loop 3
                system("mpg321 -q --stereo " . $word_lemma_address);
                $end_time = (`date +%s~` * 1000) + int(`date +%N` / 1000000);
                if ($debug)
                {
                    print $end_time, "\n";
                }
                $period = $end_time - $start_time;
                while ($period < 0)
                {
                    $period += 1000;
                }
                if ($debug)
                {
                    print $period, "\n";
                }
                if ($slow)
                {
                    usleep($period * 1000);
                }
            }
        }
        else
        {
            print "not exist", "\n";
        }
    }
}
