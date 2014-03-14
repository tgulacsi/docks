package Girocco::Config;

use strict;
use warnings;


## Basic settings

# Name of the service
our $name = "GiroccoEx";

# Nickname of the service (undef for initial part of $name upto first '.')
our $nickname = undef;

# Title of the service (as shown in gitweb)
our $title = "UNOSOFT Girocco Hosting";

# Path to the Git binary to use (you MUST set this, even if to /usr/bin/git!)
our $git_bin = '/usr/bin/git';

# Path to the git-http-backend binary to use (undef to use /usr/lib/git-core/git-http-backend)
# If both $httppullurl and $httpspushurl are undef this will never be used
# This should usually be set to `printf %s \$($git_bin --exec-path)/git-http-backend`
# which is to say the git-http-backend binary located in the --exec-path directory of $git_bin.
our $git_http_backend_bin = undef;

# Name (if in $PATH) or full path to netcat executable that accepts a -U option
# to connect to a unix socket.  This may simply be 'nc' on many systems.
our $nc_openbsd_bin = 'nc.openbsd';

# Path to the sendmail instance to use.  It should understand the -f <from>, -i and -t
# options as well as accepting a list of recipient addresses in order to be used here.
# You MUST set this, even if to '/usr/sbin/sendmail'!
# Setting this to 'sendmail.pl' is special and will automatically be expanded to
# a full path to the ../bin/sendmail.pl executable in this Girocco installation.
# sendmail.pl is a sendmail-compatible script that delivers the message directly
# using SMTP to a mail relay host.  This is the recommended configuration as it
# minimizes the information exposed to recipients (no sender account names or uids),
# can talk to an SMTP server on another host (eliminating the need for a working
# sendmail and/or SMTP server on this host) and avoids any unwanted address rewriting.
# By default it expects the mail relay to be listening on localhost port 25.
# See the sendmail.pl section below for more information on configuring sendmail.pl.
our $sendmail_bin = 'sendmail.pl';

# E-mail of the site admin
our $admin = 'admin@unosoft.hu';

# Sender of emails
# This is the SMTP 'MAIL FROM:' value
# It will be passed to $sendmail_bin with the -f option
# Some sites may not allow non-privileged users to pass the -f option to
# $sendmail_bin.  In that case set this to undef and no -f option will be
# passed which means the 'MAIL FROM:' value will be the user the mail is
# sent as (either $cgi_user or $mirror_user depending on the activity).
# To avoid having bounce emails go to $admin, this may be set to something
# else such as 'admin-noreply@example.org' and then the 'admin-noreply' address
# may be redirected to /dev/null.  Setting this to '' or '<>' is not
# recommended because that will likely cause the emails to be marked as SPAM
# by the receiver's SPAM filter.  If $sendmail_bin is set to 'sendmail.pl' this
# value must be acceptable to the receiving SMTP server as a 'MAIL FROM:' value.
# If this is set to undef and 'sendmail.pl' is used, the 'MAIL FROM:' value will
# be the user the mail is sent as (either $cgi_user or $mirror_user).
our $sender = $admin;

# Copy $admin on failure/recovery messages?
our $admincc = 1;

# Girocco branch to use for html.cgi view source links (undef for HEAD)
our $giroccobranch = undef;


## Feature knobs

# Enable mirroring mode if true
our $mirror = 1;

# Enable push mode if true
our $push = 1;

# Enable user management if true; this means the interface for registering
# user accounts and uploading SSH keys. This implies full chroot.
our $manage_users = 1;

# Minimum key length (in bits) for uploaded SSH RSA/DSA keys.
# If this is not set (i.e. undef) keys as small as 512 bits will be allowed.
# Nowadays keys less than 2048 bits in length should probably not be allowed.
# Note, however, that versions of OpenSSH starting with 4.3p1 will only generate
# DSA keys of exactly 1024 bits in length even though that length is no longer
# recommended.  (OpenSSL can be used to generate DSA keys with lengths > 1024.)
# OpenSSH does not have any problem generating RSA keys longer than 1024 bits.
# This setting is only checked when new keys are added so setting it/increasing it
# will not affect existing keys.  For maximum compatibility a value of 1024 may
# be used however 2048 is recommended.  Setting it to anything other than 1024,
# 2048 or 3072 may have the side effect of making it very difficult to generate
# DSA keys that satisfy the restriction (but RSA keys should not be a problem).
# Note that no matter what setting is specified here keys smaller than 512 bits
# will never be allowed via the reguser.cgi/edituser.cgi interface.
our $min_key_length = 1024;

# Disable DSA public keys?
# If this is set to 1, adding DSA keys at reguser.cgi/edituser.cgi time will be
# prohibited.  If $pushurl is undef then this is implicitly set to 1 since DSA
# keys are not usable with https push.
# OpenSSH will only generate 1024 bit DSA keys starting with version 4.3p1.
# Even if OpenSSL is used to generate a longer DSA key (which can then be used
# with OpenSSH), the SSH protocol itself still forces use of SHA-1 in the DSA
# signature blob which tends to defeat the purpose of going to a longer key in
# the first place.  So it may be better from a security standpoint to simply
# disable DSA keys especially if $min_key_length and $rsakeylength have been set
# to something higher such as 3072 or 4096.  This setting is only checked when
# new keys are added so setting it/increasing it will not affect existing keys.
# There is no way to disable DSA keys in the OpenSSH server config file itself.
our $disable_dsa = 0;

# Enable the special 'mob' user if set to 'mob'
our $mob = "mob";

# Let users set admin passwords; if false, all password inputs are assumed empty.
# This will make new projects use empty passwords and all operations on them
# unrestricted, but you will be able to do no operations on previously created
# projects you have set a password on.
our $project_passwords = 1;

# How to determine project owner; 'email' adds a form item asking for their
# email contact, 'source' takes realname of owner of source repository if it
# is a local path (and empty string otherwise). 'source' is suitable in case
# the site operates only as mirror of purely local-filesystem repositories.
our $project_owners = 'email';

# Which project fields to make editable, out of 'shortdesc', 'homepage',
# 'README', 'notifymail', 'notifyjson', 'notifycia'. (This is currently
# soft restriction - form fields aren't used, but manually injected values
# *are* used. Submit a patch if that's an issue for you.)
our @project_fields = qw(homepage shortdesc README notifymail notifyjson notifycia);

# Minimal number of seconds to pass between two updates of a project.
our $min_mirror_interval = 3600; # 1 hour

# Minimal number of seconds to pass between two garbage collections of a project.
our $min_gc_interval = 604800; # 1 week

# Whether or not to run the ../bin/update-pwd-db script whenever the etc/passwd
# database is changed.  This is typically needed (i.e. set to a true value) for
# FreeBSD style systems when using an sshd chroot jail for push access.  So if
# $pushurl is undef or the system Girocco is running on is not like FreeBSD
# (e.g. a master.passwd file that must be transformed into pwd.db and spwd.db), then
# this setting should normally be left false (i.e. 0).  See comments in the
# provided ../bin/update-pwd-db script about when and how it's invoked.
our $update_pwd_db = 0;

# Port the sshd running in the jail should listen on
# Be sure to update $pushurl to match
# Not used if $pushurl is undef
our $sshd_jail_port = 2244;


## Paths

# Path where the main chunk of Girocco files will be installed
# This will get COMPLETELY OVERWRITTEN by each make install!!!
our $basedir = '/home/repo/repomgr';

# Path where the automatically generated non-user certificates will be stored
# (The per-user certificates are always stored in $chroot/etc/sshcerts/)
# This is preserved by each make install and MUST NOT be under $basedir!
our $certsdir = '/home/repo/sshcerts';

# The repository collection
# "$reporoot-recyclebin" will also be created for use by toolbox/trash-project.pl
our $reporoot = "/srv/git";

# The repository collection's location within the chroot jail
# Normally $reporoot will be bind mounted onto $chroot/$jailreporoot
# Should NOT start with '/'
our $jailreporoot = "srv/git";

# The chroot for ssh pushing; location for project database and other run-time
# data even in non-chroot setups
our $chroot = "/home/repo/j";

# The gitweb files web directory (corresponds to $gitwebfiles)
our $webroot = "/home/repo/WWW";

# The CGI-enabled web directory (corresponds to $gitweburl and $webadmurl)
our $cgiroot = "/home/repo/WWW";

# A web-accessible symlink to $reporoot (corresponds to $httppullurl, can be undef)
our $webreporoot = "/home/repo/WWW/r";


## Certificates (only used if $httpspushurl is defined)

# path to root certificate (undef to use automatic root cert)
# this certificate is made available for easy download and should be whatever
# the root certificate is for the https certificate being used by the web server
our $rootcert = undef;

# The certificate to sign user push client authentication certificates with (undef for auto)
# The automatically generated certificate should always be fine
our $clientcert = undef;

# The private key for $clientcert (undef for auto)
# The automatically generated key should always be fine
our $clientkey = undef;

# The client certificate chain suffix (a pemseq file to append to user client certs) (undef for auto)
# The automatically generated chain should always be fine
# This suffix will also be appended to the $mobusercert before making it available for download
our $clientcertsuffix = undef;

# The mob user certificate signed by $clientcert (undef for auto)
# The automatically generated certificate should always be fine
# Not used unless $mob is set to 'mob'
# The $clientcertsuffix will be appended before making $mobusercert available for download
our $mobusercert = undef;

# The private key for $mobusercert (undef for auto)
# The automatically generated key should always be fine
# Not used unless $mob is set to 'mob'
our $mobuserkey = undef;

# The key length for automatically generated RSA private keys (in bits).
# These keys are then used to create the automatically generated certificates.
# If undef or set to a value less than 2048, then 2048 will be used.
# Set to 3072 to generate more secure keys/certificates.  Set to 4096 (or higher) for
# even greater security.  Be warned that setting to a non-multiple of 8 and/or greater
# than 4096 could negatively impact compatibility with some clients.
# The values 2048, 3072 and 4096 are expected to be compatible with all clients.
# Note that OpenSSL has no problem with > 4096 or non-multiple of 8 lengths.
# See also the $min_key_length setting above to restrict user key sizes.
our $rsakeylength = undef;


## URL addresses

# URL of the gitweb.cgi script (must be in pathinfo mode)
our $gitweburl = "http://repo.unosoft.hu/w";

# URL of the extra gitweb files (CSS, .js files, images, ...)
our $gitwebfiles = "http://repo.unosoft.hu";

# URL of the Girocco CGI web admin interface (Girocco cgi/ subdirectory)
our $webadmurl = "http://repo.unosoft.hu";

# URL of the Girocco CGI html templater (Girocco cgi/html.cgi)
our $htmlurl = "http://repo.unosoft.hu/h";

# HTTP URL of the repository collection (undef if N/A)
our $httppullurl = "http://repo.unosoft.hu/r";

# HTTPS push URL of the repository collection (undef if N/A)
# If this is defined, the openssl command must be available
# Normally this should be set to $httppullurl with http: replaced with https:
our $httpspushurl = undef;

# Git URL of the repository collection (undef if N/A)
# (You need to set up git-daemon on your system, and Girocco will not
# do this particular thing for you.)
our $gitpullurl = "git://repo.unosoft.hu";

# Pushy SSH URL of the repository collection (undef if N/A)
our $pushurl = "ssh://repo.unosoft.hu:2244/$jailreporoot";

# URL of gitweb of this Girocco instance (set to undef if you're not nice
# to the community)
our $giroccourl = "$Girocco::Config::gitweburl/girocco.git";


## Some templating settings

# Legal warning (on reguser and regproj pages)
our $legalese = <<EOT;
<p>By submitting this form, you are confirming that you will mirror or push
only what we can store and show to anyone else who can visit this site without
breaking any law, and that you will be nice to all small furry animals.
<sup><a href="/h/about.html">(more details)</a></sup>
</p>
EOT

# Pre-configured mirror sources (set to undef for none)
# Arrayref of name - record pairs, the record has these attributes:
#	label: The label of this source
# 	url: The template URL; %1, %2, ... will be substituted for inputs
#	desc: Optional VERY short description
#	link: Optional URL to make the desc point at
#	inputs: Arrayref of hashref input records:
#		label: Label of input record
#		suffix: Optional suffix
#	If the inputs arrayref is undef, single URL input is shown,
#	pre-filled with url (probably empty string).
our $mirror_sources = [
	{
		label => 'Anywhere',
		url => '',
		desc => 'Any HTTP/Git/rsync pull URL - bring it on!',
		inputs => undef
	},
	{
		label => 'GitHub',
		url => 'git://github.com/%1/%2.git',
		desc => 'GitHub Social Code Hosting',
		link => 'http://github.com/',
		inputs => [ { label => 'User:' }, { label => 'Project:', suffix => '.git' } ]
	},
	{
		label => 'Gitorious',
		url => 'git://gitorious.org/%1/%2.git',
		desc => 'Green and Orange Boxes',
		link => 'http://gitorious.org/',
		inputs => [ { label => 'Project:' }, { label => 'Repository:', suffix => '.git' } ]
	}
];

# You can customize the gitweb interface widely by editing
# gitweb/gitweb_config.perl


## Permission settings

# Girocco needs some way to manipulate write permissions to various parts of
# all repositories; this concerns three entities:
# - www-data: the web interface needs to be able to rewrite few files within
# the repository
# - repo: a user designated for cronjobs; handles mirroring and repacking;
# this one is optional if not $mirror
# - others: the designated users that are supposed to be able to push; they
# may have account either within chroot, or outside of it

# There are several ways how to use Girocco based on a combination of the
# following settings.

# (Non-chroot) UNIX user the CGI scripts run on; note that if some non-related
# untrusted CGI scripts run on this account too, that can be a big security
# problem and you'll probably need to set up suexec (poor you).
# This must always be set.
our $cgi_user = 'www-data';

# (Non-chroot) UNIX user performing mirroring jobs; this is the user who
# should run all the daemons and cronjobs and
# the user who should be running make install (if not root).
# This must always be set.
our $mirror_user = 'repo';

# (Non-chroot) UNIX group owning the repositories by default; it owns whole
# mirror repositories and at least web-writable metadata of push repositories.
# If you undefine this, all the data will become WORLD-WRITABLE.
# Both $cgi_user and $mirror_user should be members of this group!
our $owning_group = 'repo';

# Whether to use chroot jail for pushing; this must be always the same
# as $manage_users.
# TODO: Gitosis support for $manage_users and not $chrooted?
our $chrooted = $manage_users;

# How to control permissions of push-writable data in push repositories:
# * 'Group' for the traditional model: The $chroot/etc/group project database
#   file is used as the UNIX group(5) file; the directories have gid appropriate
#   for the particular repository and are group-writable. This works only if
#   $chrooted so that users are put in the proper groups on login when using
#   SSH push.  Smart HTTPS push does not require a chroot to work -- simply
#   run "make install" as the non-root $mirror_user user, but leave
#   $manage_users and $chrooted enabled.
# * 'ACL' for a model based on POSIX ACL: The directories are coupled with ACLs
#   listing the users with push permissions. This works for both chroot and
#   non-chroot setups, however it requires ACL support within the filesystem.
#   This option is BASICALLY UNTESTED, too. And UNIMPLEMENTED. :-)
# * 'Hooks' for a relaxed model: The directories are world-writable and push
#   permission control is purely hook-driven. This is INSECURE and works only
#   when you trust all your users; on the other hand, the attack vectors are
#   mostly just DoS or fully-traceable tinkering.
our $permission_control = 'Group';

# Path to alternate screen multiuser acl file (see screen/README, undef for none)
our $screen_acl_file = undef;


## sendmail.pl configuration

# Full information on available sendmail.pl settings can be found by running
# ../bin/sendmail.pl -v -h

# These settings will only used if $sendmail_bin is set to 'sendmail.pl'

# sendmail.pl host name
#$ENV{'SENDMAIL_PL_HOST'} = 'localhost'; # localhost is the default

# sendmail.pl port name
#$ENV{'SENDMAIL_PL_PORT'} = '25'; # port 25 is the default

# sendmail.pl nc executable
#$ENV{'SENDMAIL_PL_NCBIN'} = "$chroot/bin/nc.openbsd"; # default is nc found in $PATH

# sendmail.pl nc options
# multiple options may be included, e.g. '-4 -X connect -x 192.168.100.10:8080'
#$ENV{'SENDMAIL_PL_NCOPT'} = '-4'; # force IPv4, default is to allow IPv4 & IPv6


## Sanity checks & defaults

# Couple of sanity checks and default settings (do not change these)
use Digest::MD5 qw(md5);
use MIME::Base64 qw(encode_base64);
$nickname = (split(/[.]/, $name))[0] unless $nickname;
our $tmpsuffix = substr(encode_base64(md5($name.':'.$nickname)),0,6);
$tmpsuffix =~ tr,+/,=_,;
($mirror_user) or die "Girocco::Config: \$mirror_user must be set even if to current user";
($basedir) or die "Girocco::Config: \$basedir must be set";
($sendmail_bin) or die "Girocco::Config: \$sendmail_bin must be set";
$sendmail_bin = "$basedir/bin/sendmail.pl" if $sendmail_bin eq "sendmail.pl";
$screen_acl_file = "$basedir/screen/giroccoacl" unless $screen_acl_file;
$jailreporoot =~ s,^/+,,;
($reporoot) or die "Girocco::Config \$reporoot must be set";
($jailreporoot) or die "Girocco::Config \$jailreporoot must be set";
(not $mob or $mob eq 'mob') or die "Girocco::Config \$mob must be undef (or '') or 'mob'";
(not $min_key_length or $min_key_length =~ /^[1-9][0-9]*$/)
	or die "Girocco::Config \$min_key_length must be undef or numeric";
$admincc = $admincc ? 1 : 0;
$rootcert = "$certsdir/girocco_root_crt.pem" if $httpspushurl && !$rootcert;
$clientcert = "$certsdir/girocco_client_crt.pem" if $httpspushurl && !$clientcert;
$clientkey = "$certsdir/girocco_client_key.pem" if $httpspushurl && !$clientkey;
$clientcertsuffix = "$certsdir/girocco_client_suffix.pem" if $httpspushurl && !$clientcertsuffix;
$mobusercert = "$certsdir/girocco_mob_user_crt.pem" if $httpspushurl && $mob && !$mobusercert;
$mobuserkey = "$certsdir/girocco_mob_user_key.pem" if $httpspushurl && $mob && !$mobuserkey;
our $mobpushurl = $pushurl;
$mobpushurl =~ s,^ssh://,ssh://mob@,i if $mobpushurl;
$disable_dsa = 1 unless $pushurl;
our $httpsdnsname = ($httpspushurl =~ m,https://([A-Za-z0-9.-]+),i) ? lc($1) : undef if $httpspushurl;
($mirror or $push) or die "Girocco::Config: neither \$mirror nor \$push is set?!";
(not $push or ($pushurl or $httpspushurl or $gitpullurl or $httppullurl)) or die "Girocco::Config: no pull URL is set";
(not $push or ($pushurl or $httpspushurl)) or die "Girocco::Config: \$push set but \$pushurl and \$httpspushurl are undef";
(not $mirror or $mirror_user) or die "Girocco::Config: \$mirror set but \$mirror_user is undef";
($manage_users == $chrooted) or die "Girocco::Config: \$manage_users and \$chrooted must be set to the same value";
(not $chrooted or $permission_control ne 'ACL') or die "Girocco::Config: resolving uids for ACL not supported when using chroot";
(grep { $permission_control eq $_ } qw(Group Hooks)) or die "Girocco::Config: \$permission_control must be set to Group or Hooks";
($chrooted or not $mob) or die "Girocco::Config: mob user supported only in the chrooted mode";
(not $httpspushurl or $httpsdnsname) or die "Girocco::Config invalid \$httpspushurl does not start with https://domainname";

1;
