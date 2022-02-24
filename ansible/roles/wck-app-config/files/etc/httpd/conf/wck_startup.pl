warn "Executing wck_startup.pl...\n";
sleep 1;

# Extend @INC if needed
use lib qw(/home/wck/MODULES/ /home/wck/htdocs/chd3/handlers);

# Make sure we are in a sane environment.
$ENV{MOD_PERL} or die "not running under mod_perl!";

# Place common modules here to be pre-loaded by the mod_perl enabled server
use ModPerl::Registry;
use Socket;

### Recycle large Apache processes

use Apache2::SizeLimit;
$Apache2::SizeLimit::MAX_PROCESS_SIZE  = 60000; # 50MB
#$Apache2::SizeLimit::MIN_SHARE_SIZE    = 6000;  # 6MB
#$Apache2::SizeLimit::MAX_UNSHARED_SIZE = 5000;  # 5MB

$Apache2::SizeLimit::CHECK_EVERY_N_REQUESTS = 20;

# ----------------- MODULE --------------------
use Common::CGI;
use CHData::CompanyPrefixes;
use CHDDB::chdCtrl;
use Common::AISHelper;
use Common::Basket;
use Common::CGIEngine;
use Common::ConstString;
use Common::CustomerHelper;
use Common::CVTable;
use Common::DateHelper;
use CommonDB::accountDetails;
use CommonDB::auth;
use CommonDB::Customer;
use CommonDB::cvClass;
use CommonDB::cvClassCollection;
use CommonDB::CVConstants qw( :DEFAULT );
use CommonDB::cvRegistry;
use CommonDB::cvValue;
use CommonDB::document;
use CommonDB::DocumentSearch;
use CommonDB::emailNotify;
use CommonDB::GSession;
use CommonDB::GSessionAdmin;
use CommonDB::notification;
use CommonDB::OrderDetail;
use CommonDB::OrderHeader;
use CommonDB::OrderSearch;
use CommonDB::profileCollection;
use Common::goBackHelper;
use Common::Insolvency;
use Common::KeyGen;
use Common::navLink;
use Common::OrderHelper;
use Common::OrderHelper;
use Common::ScreenInfo;
use Common::URIHelper;
use Common::XMLMapper;
use Data::Dumper;
use Digest::MD5 qw(md5_hex);
use File::Basename;
use File::Copy;
use HTML::Template;
use POSIX qw(strftime);
use Time::Local;
use Tuxedo::Error;
use Tuxedo::Service;
use XML::Simple;

# Set some ENV variables for Perl
#
warn "Setting Orcale Environment Variables\n";
$ENV{ORACLE_HOME}="/usr/lib/oracle/11.2/client64/";
$ENV{LD_LIBRARY_PATH}="/usr/lib/oracle/11.2/client64/lib/";
$ENV{TNS_ADMIN}="/usr/lib/oracle/11.2/client64/lib/";

$ENV{NLS_LANG}   = "ENGLISH_UNITED KINGDOM.UTF8";
$ENV{LC_ALL}     = "en_GB.UTF-8";
$ENV{DBCONNECT_PING_RATE}=40;

warn "wck_startup.pl - done\n";
1;
