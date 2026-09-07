use strict;
use 5.10.0;

$/ = "";

my $dq= '"';
my $qn = 0;
my $option;
my $optmax=5;
while (<>){
	chomp;
	## This is MC option scoring stuff
	my $val=0;
	$val = 100 if s/^[*]\s*//;

	## Deleted a bunch of latex/dmu processing stuff from the covid era.
	## Could restore it if this script migrates back to older courses
	## Originally based on ../3Tests/mcave.pl
	## Look there also for $comment if you want to rebuild online tests,
	## hoping this will not be necessary
	## Deleting a bunch of 3SS formatting stuff as well (see just above)
	## s/\\blank\\*/________/g;

	## Some hot changes for now 2026 Sep 06 (Sun)
	## NOT! See saquiz.md
	## s|_([A-Za-z-\s]+)_|<em>$1</em>|;

	## Awkwardly chopped from longer comment-based chain
	if (/^INTRO\s*/){
		s/^INTRO\s*//;
		## xclip forks a background daemon to hold the selection; that daemon
		## inherits our stdout/stderr, so if those are a pipe (as under make)
		## the reader hangs waiting for EOF unless we redirect xclip's away.
		open(my $clip, "|-", "xclip -selection clipboard >/dev/null 2>&1") or die "Can't open xclip: $!";
		print $clip $_;
		close $clip;
	}
	elsif (/^ANS/){}
	## This part is tricky. Maybe merge somehow the MC and SA stuff?
	elsif (/^MC/){}
	elsif (/^SA/){
		$qn++;
		$option=0;
		my $id = sprintf("2020F%2d", $qn);
		$id =~ s/ /0/g;
		my $tit = $_;
		$tit =~ s/[^\w\s]//g;
		$tit = join("_", (split /\s/, $tit)[2..3]);
		say "";
		say "NewQuestion,SA,";
		say "ID,$id";
		say "Title,$tit";
		say "Answer,100,.+,regexp";
		say "QuestionText,$dq$_$dq,";
		say "Points,1,";
		say "Difficulty,1,";
	}
	else{
		$option ++;
		die ("Suspicious option $_") if $option > $optmax;
		say "Option,$val,$dq$_$dq,,";
	}
}

