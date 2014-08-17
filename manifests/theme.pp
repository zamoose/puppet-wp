define wp::theme (
	$slug = $title,
	$location,
	$ensure = enabled
) {
	include wp::cli

	case $ensure {
		enabled: {
			if ("/usr/bin/wp theme is-installed \"$slug\""){
				wp::command { "$location theme install \"$slug\"":
					location => $location,
					command => "theme install \"$slug\"",
				}
			}
			wp::command { "$location theme activate \"$slug\"":
				location	=> $location,
				command	=> "theme activate \"$slug\"",
				require	=> Wp::Command["$location theme install \"$slug\""];
			}
		}
		installed: {
			if ("/usr/bin/wp theme is-installed \"$slug\""){
				wp::command { "$location theme install \"$slug\"":
					location => $location,
					command => "theme install \"$slug\"",
				}
			}
		}
		default: {
			fail("Invalid ensure for wp::theme")
		}
	}
}
