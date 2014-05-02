define wp::download (
	$location = $title,
	$locale         = false,
	$version        = false,
	$force          = false
) {
	include wp::cli

	$download = ''

	if ( $locale != false ) {
		$s_locale = "--locale='$locale' "
	}

	if ( $version != false ) {
		$s_version = "--version='$version' "
	}

	if ( $force != false ) {
		$s_force = "--force"
	}

	exec {"wp core download $location":
		command => "/usr/bin/wp core download $download $s_locale $s_version $s_force",
		cwd => $location,
                user => $::wp::user,
		require => [ Class['wp::cli'] ],
		creates => [ "$location/wp-admin", "$location/wp-content", "$location/wp-includes" ]
	}
}
