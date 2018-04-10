#!/usr/bin/perl

print "perl divide.pl tmp1.txt\n";
print "press spacebar for known, enter button for unknown.\n";
print "q for quit.\n";
# use strict;
# use warnings;
use Time::HiRes qw(usleep nanosleep);
use Term::ReadKey;
$youdao_address = '/home/toby/dict/youdao/american/';
$webster_address = '/home/toby/dict/webster/';
$lingoes_address = "/home/toby/dict/lingoes/";
$play_times = 100;
$num_args = $#ARGV + 1;
$debug = 0;
$slow = 1;
$words_file = $ARGV[0];
if ($num_args > 1)
{
    $play_times = $ARGV[1];
}
if ($debug)
{
    print $num_args, "\n";
    print $play_times, "\n";
}

sub readkey {
        ReadMode('cbreak'); #  4; # Turn off controls keys
        my $key = ReadKey(-1);
        if (!defined($key))
        {
          $key = 0;
        }
        ReadMode('normal'); # 0;   # Reset tty mode before exiting
        return ord($key);
}

sub save_word {
    my $key = readkey();
    my $file = substr($words_file, 0, -4);
    if ($key == 32)
    {
      #save to known words file
      $file .= "_0.txt";
      print "saved known $word in $file\n";
      system("echo $word >> $file");
    }
    elsif ($key == 10)
    {
      #save to unknown words file
      $file .= "_1.txt";
      print "saved unknown $word in $file\n";
      system("echo $word >> $file");
    }    
    elsif ($key == 113) # q for quit
    {
      exit();
    }
    else
    {
      $key = 0;
    }
    return $key;
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
        $word_webster_address = $webster_address . substr($word, 0, 1) . "/" .  $word . ".wav";
        $word_lingoes_address = $lingoes_address . substr($word, 0, 1) . "/" .  $word . ".mp3";
        
        print $word, "\n";
        if ($debug)
        {
            print $word_youdao_address, "\n";
        }
        $time_i = $play_times;
        if (-e $word_youdao_address)
        {
            while ($time_i-- > 0)
            {
                if (save_word() > 0) {
                  last;
                }
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
                if (save_word() > 0) {
                    last;
                }
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
                if (save_word() > 0) {
                  last;
                }
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
        else
        {
            print "not exist", "\n";
        }
    }
}

