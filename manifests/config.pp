define wp::config (
	$location = $title,
	$dbname,
	$dbuser,
	$dbpass,
	$dbhost		= false,
	$dbprefix		= false,
	$dbcharset		= false,
	$dbcollate		= false,
	$locale			= false,
	$extraphp		= false
) {
	include wp::cli

	$config = ''

	if ( $dbhost != false ) {
		$db_host = "--dbhost='$dbhost' "
	}

	if ( $dbprefix != false ) {
		$db_prefix = "--dbprefix='$dbprefix' "
	}

	if ( $dbcharset != false ) {
		$db_charset= "--dbcharset='$dbcharset' "
	}

	if ( $dbcollate != false ) {
		$db_collate = "--dbcollate='$dbcollate' "
	}

	if ( $locale != false ) {
		$db_locale = "--locale='$locale' "
	}

	if ( $extraphp != false ) {
		$extra_php = "--extra-php $extraphp"
	}
	exec {"wp core config $location":
		command => "/usr/bin/wp core config --dbname='$dbname' --dbuser='$dbuser' --dbpass='$dbpass' $db_host $db_prefix $db_charset $db_collate $db_locale $extra_php",
		cwd => $location,
		user => $::wp::user,
		require => [ Class['wp::cli'] ],
		creates => "$location/wp-config.php"
	}
}
